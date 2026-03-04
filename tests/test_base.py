import unittest
import os
import faulthandler
import threading
import gc
import tracemalloc
import psutil
import time
import cProfile, pstats, io
import sys
from collections import defaultdict
from pathlib import Path

import cowl
from cowl.data_prop_assert_axiom import DataPropAssertAxiom
from cowl.obj_prop_assert_axiom import ObjPropAssertAxiom
from cowl.cls_assert_axiom import ClsAssertAxiom
from cowl.sub_cls_axiom import SubClsAxiom

# ================================
#  PARSING ARGOMENTI CLI (facoltativo)
# ================================
def parse_cli_flags():
    """Interpreta flag come --perf, --memcheck, --profile e imposta le variabili d’ambiente."""
    args = sys.argv[:]
    enabled = []
    for flag, var in {
        "--perf": "PERF",
        "--memcheck": "MEMCHECK",
        "--profile": "PROFILE",
    }.items():
        if flag in args:
            os.environ[var] = "1"
            enabled.append(flag)
            args.remove(flag)

    # Aggiorna sys.argv per evitare errori con unittest
    sys.argv = args

    if enabled:
        print(f"⚙️  Attivate opzioni: {', '.join(enabled)}")
    return enabled

parse_cli_flags()


# ================================
#  COSTANTI E INIZIALIZZAZIONE
# ================================
TEST_DIR = Path(__file__).parent
RES_DIR = TEST_DIR / "res"

# Abilita faulthandler per debug
faulthandler.enable()
faulthandler.dump_traceback_later(30, repeat=True)

def start_watchdog(timeout=60):
    """Timer di sicurezza: se un test si blocca, stampa gli stack di tutti i thread."""
    timer = threading.Timer(timeout, faulthandler.dump_traceback, kwargs={"all_threads": True})
    timer.daemon = True
    timer.start()
    return timer

# ================================
#  COLORI TERMINALE
# ================================
class _Color:
    GREEN = "\033[92m"
    RED = "\033[91m"
    YELLOW = "\033[93m"
    BLUE = "\033[94m"
    CYAN = "\033[96m"
    BOLD = "\033[1m"
    RESET = "\033[0m"


# ================================
#  DECORATORI UTILI
# ================================
def measure_performance(func):
    """Misura tempo e memoria RSS durante l’esecuzione di un test (attivabile con PERF=1)."""
    def wrapper(self, *args, **kwargs):
        if not os.getenv("PERF"):  # Se la variabile non è attiva → salta la misurazione
            return func(self, *args, **kwargs)
        process = psutil.Process(os.getpid())
        start_time = time.perf_counter()
        start_rss = process.memory_info().rss
        result = func(self, *args, **kwargs)
        elapsed = time.perf_counter() - start_time
        end_rss = process.memory_info().rss
        rss_diff = (end_rss - start_rss) / 1024
        print(f"{_Color.BOLD}{_Color.CYAN}⏱ {func.__name__}:{_Color.RESET} {elapsed*1000:.2f} ms | ΔRSS: {rss_diff:.1f} KiB")
        return result
    return wrapper

def profile_func(func):
    """Profiling CPU opzionale se PROFILE=1"""
    def wrapper(self, *args, **kwargs):
        if not os.getenv("PROFILE"):
            return func(self, *args, **kwargs)
        pr = cProfile.Profile()
        pr.enable()
        result = func(self, *args, **kwargs)
        pr.disable()
        s = io.StringIO()
        ps = pstats.Stats(pr, stream=s).sort_stats('tottime')
        ps.print_stats(10)
        print(f"\n{_Color.YELLOW}Profiling {func.__name__}:{_Color.RESET}\n{s.getvalue()}")
        return result
    return wrapper

# ================================
#  TEST SUITE
# ================================
class BasicTest(unittest.TestCase):
    """Test base per il pacchetto COWL con controllo memoria integrato."""

    _global_mem_report = defaultdict(list)
    manager = None
    ontology = None
    ontology_selected = "test.owl"

    # ================================
    #  SETUP / TEARDOWN DI CLASSE
    # ================================
    @classmethod
    def setUpClass(cls):
        super().setUpClass()

    @classmethod
    def tearDownClass(cls):
        """Report memoria complessivo."""
        if BasicTest._global_mem_report:
            rss_total = sum(BasicTest._global_mem_report["rss"])
            heap_total = sum(BasicTest._global_mem_report["heap"])
            obj_total = sum(BasicTest._global_mem_report["objs"])

            def fmt_diff(val):
                color = _Color.GREEN if val <= 0 else _Color.RED
                sign = "+" if val > 0 else ""
                return f"{color}{sign}{val/1024:.1f} KiB{_Color.RESET}"

            def fmt_objs(val):
                color = _Color.GREEN if val <= 0 else _Color.RED
                sign = "+" if val > 0 else ""
                return f"{color}{sign}{val}{_Color.RESET}"

            print(f"\n{_Color.BOLD}{_Color.BLUE}===============================")
            print(f"     MEMORY LEAK SUMMARY")
            print(f"===============================")
            print(f"Totale crescita RSS:  {fmt_diff(rss_total)}")
            print(f"Totale crescita Heap: {fmt_diff(heap_total)}")
            print(f"Totale crescita Obj:  {fmt_objs(obj_total)}")
            print(f"===============================\n{_Color.RESET}")

        super().tearDownClass()

    # ================================
    #  SETUP / TEARDOWN TEST
    # ================================
    def setUp(self):
        super().setUp()
        gc.collect()
        self._process = psutil.Process(os.getpid())
        self._rss_before = self._process.memory_info().rss
        self._obj_count_before = len(gc.get_objects())
        if os.getenv("MEMCHECK"):
            tracemalloc.start(50)
            self._snap_before = tracemalloc.take_snapshot()

    def tearDown(self):
        try:
            if os.getenv("MEMCHECK"):
                gc.collect()
                snap_after = tracemalloc.take_snapshot()
                rss_after = self._process.memory_info().rss
                obj_count_after = len(gc.get_objects())

                diff_stats = snap_after.compare_to(self._snap_before, 'traceback')
                total_diff = sum(stat.size_diff for stat in diff_stats)
                rss_diff = rss_after - self._rss_before
                obj_diff = obj_count_after - self._obj_count_before

                BasicTest._global_mem_report["rss"].append(rss_diff)
                BasicTest._global_mem_report["heap"].append(total_diff)
                BasicTest._global_mem_report["objs"].append(obj_diff)
                
                tracemalloc.stop()
        finally:
            super().tearDown()

    # ================================
    #  TEST ORIGINALI (refactor)
    # ================================

    def test_cowl_installed(self):
        manager = cowl.Manager()
        self.assertIsNotNone(manager)
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        self.assertIsNotNone(ontology)
    
    @profile_func
    @measure_performance
    def test_print(self):
        try:
            manager = cowl.Manager()
            ontology = manager.read_path(str(RES_DIR / "home.owl"))
            manager.write_path(ontology, str(RES_DIR / "temp.owl"))
            s1 = manager.write_str(ontology)
            #print(s1)
            ont2 = manager.read_path(str(RES_DIR / "temp.owl"))
            s2 = manager.write_str(ont2)
            #print(s2)
            os.remove(str(RES_DIR / "temp.owl"))
        except Exception as e:
            print(f"Si è verificato un errore nella funzione test_print: {e}")
            raise

    @profile_func
    @measure_performance
    def test_ontology_iterate_axioms(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.iterate_axioms()

    @profile_func
    @measure_performance
    def test_data_prop_assert_axiom(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        axioms = list(ontology.iterate_axioms_of_type(cowl.AxiomType.DATA_PROP_ASSERT))

        if axioms:
            DataPropAssertAxiom(axioms[len(axioms)-1].get_prop(), 
                                axioms[0].get_subject(), 
                                axioms[len(axioms)-1].get_object(), 
                                axioms[0].get_annot())
            for ax in axioms:
                ax.is_negative()
                ax.get_prop()
                ax.get_subject()
                ax.get_object()
                ax.get_negative()

    @profile_func
    @measure_performance
    def test_class_assert_axiom(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        axioms = list(ontology.iterate_axioms_of_type(cowl.AxiomType.CLASS_ASSERT))
        if axioms:
            ClsAssertAxiom(axioms[0].get_cls_exp(),
                           axioms[len(axioms)-1].get_ind(),
                           axioms[0].get_annot())
            for ax in axioms:
                ax.get_cls_exp()
                ax.get_ind()

    @profile_func
    @measure_performance
    def test_sub_class_axiom(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        axioms = list(ontology.iterate_axioms_of_type(cowl.AxiomType.SUB_CLASS))
        if axioms:
            SubClsAxiom(axioms[0].get_sub(), 
                        axioms[len(axioms)-1].get_super(), 
                        axioms[0].get_annot())
            for ax in axioms:
                ax.get_sub()
                ax.get_super()
                ax.get_annot()

    @profile_func
    @measure_performance
    def test_obj_prop_assert_axiom(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        axioms = list(ontology.iterate_axioms_of_type(cowl.AxiomType.OBJ_PROP_ASSERT))
        if axioms:
            ObjPropAssertAxiom(axioms[len(axioms)-1].get_prop(), 
                               axioms[0].get_subject(), 
                               axioms[len(axioms)-1].get_object(), 
                               axioms[0].get_annot())
            for ax in axioms:
                ax.is_negative()
                ax.get_prop()
                ax.get_subject()
                ax.get_object()
                ax.get_negative()

    @profile_func
    @measure_performance
    def test_ontology_iterate_primitives(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.iterate_primitives(cowl.PrimitiveFlags.ALL, True)

    @profile_func
    @measure_performance
    def test_ontology_iterate_axioms_of_type(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.iterate_axioms_of_type(cowl.AxiomType.SUB_CLASS, True)

    @profile_func
    @measure_performance
    def test_iterate_axioms_of_types(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.iterate_axioms_of_types(cowl.AxiomFlags.SUB_CLASS, True)

    @profile_func
    @measure_performance
    def test_axiom_count(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.axiom_count(False)

    @profile_func
    @measure_performance
    def test_primitives_count(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.primitives_count(cowl.PrimitiveFlags.ALL, False)

    @profile_func
    @measure_performance
    def test_iterate_import_iris(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.iterate_import_iris(True)

    @profile_func
    @measure_performance
    def test_axiom_count_for_type(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.axiom_count_for_type(cowl.AxiomType.SUB_CLASS, True)

    @profile_func
    @measure_performance
    def test_axiom_count_for_types(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        ontology.axiom_count_for_types(cowl.AxiomFlags.SUB_CLASS, True)

    @profile_func
    @measure_performance
    def test_has_axiom(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        axioms = list(ontology.iterate_axioms())
        if axioms:
            ontology.has_axiom(axioms[0], False)

    @profile_func
    @measure_performance
    def test_has_primitive(self):
        manager = cowl.Manager()
        ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
        primitives = list(ontology.iterate_primitives(cowl.PrimitiveFlags.ALL, False))
        if primitives:
            ontology.has_primitive(primitives[0], False) 
    
    @profile_func
    @measure_performance
    def test_extract_subontology(self):
        # Testa l'estrazione di una sotto-ontologia basata su una classe specifica.
        try:
            manager = cowl.Manager()
            ontology = manager.read_path(str(RES_DIR / self.ontology_selected))
            # Otteniamo prima tutte le classi
            class_primitives = list(ontology.iterate_primitives(cowl.PrimitiveFlags.CLASS, True))

            if not class_primitives:
                self.skipTest("Nessuna classe trovata nell'ontologia")

            # Prendiamo la prima classe come radice per la sotto-ontologia
            root_class = class_primitives[0]

            # Creiamo una nuova ontologia vuota
            sub_ontology = manager.new_ontology()
            if sub_ontology is None:
                raise ValueError("Impossibile creare la nuova ontologia")

            try:
                # Raccogliamo tutti gli assiomi dall'ontologia originale
                axioms = []
                try:
                    axioms = list(ontology.iterate_axioms())
                except Exception as e:
                    print(f"Errore durante l'iterazione degli assiomi: {e}")
                    raise

                # Iteriamo attraverso gli assiomi e aggiungiamo quelli relativi alla classe radice
                for i, axiom in enumerate(axioms, 1):
                    try:
                        if axiom is None:
                            continue

                        # Verifica se l'assioma contiene la classe radice
                        axiom_str = str(axiom)
                        root_str = str(root_class)

                        if root_str in axiom_str:
                            ret = sub_ontology.add_axiom(axiom)
                            if ret != 0:
                                print(f"Errore nell'aggiunta dell'assioma {i}")

                    except Exception as e:
                        print(f"Errore durante l'elaborazione dell'assioma {i}: {e}")
                        continue

            except Exception as e:
                print(f"Errore durante l'elaborazione degli assiomi: {e}")
                raise

        except Exception as e:
            print(f"Errore generale in test_extract_subontology: {e}")
            raise

if __name__ == "__main__":
    unittest.main(verbosity=2)
