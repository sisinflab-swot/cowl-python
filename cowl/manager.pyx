"""Implementation of manager and ontology objects"""
import cowl
from cowl.object cimport Object
from cowl.manager cimport CowlManager, CowlOntology, Ontology
from cowl.any cimport CowlAny, CowlAnyPrimitive, CowlAnyAxiom
from cowl.manager cimport cowl_manager
from cowl.ontology cimport cowl_ontology_iterate_axioms, cowl_ontology_iterate_primitives, cowl_ontology_axiom_count, cowl_ontology_primitives_count, cowl_ontology_iterate_axioms_of_type, cowl_ontology_iterate_import_iris, cowl_ontology_iterate_axioms_of_types, cowl_ontology_has_primitive, cowl_ontology_has_axiom, cowl_ontology_axiom_count_for_type, cowl_ontology_axiom_count_for_types, cowl_ontology_axiom_count_for_primitive, cowl_ontology_iterate_axioms_for_primitive, cowl_ontology_add_axiom
from cowl.ret cimport cowl_ret
from cowl.iterator cimport CowlIterator, Iterator
from cowl.ulib cimport UString, UStrBuf, pystr_to_ustring, ustring_to_pystr, ustrbuf_to_ustring, ustrbuf, ustring_deinit
from cowl.axiom_type cimport CowlAxiomType
from cowl.primitive_flags cimport CowlPrimitiveFlags
from cowl.axiom_flags cimport CowlAxiomFlags
from cowl.axiom cimport Axiom
from cowl.primitive cimport Primitive

cdef class Manager(Object):
    """
    Implementation of Manager wrapper for CowlManager. For now, this class includes the ability
    of read ontologies from strings and paths.
    """
    def __init__(self):
        super().__init__()
        self.c_obj = cowl_manager()

    def read_path(self, path: str):
        cdef UString path_str = pystr_to_ustring(path)
        cdef CowlAny *ontology_ptr = <CowlAny *> cowl_manager_read_path(<CowlManager *> self.c_obj, path_str)

        if ontology_ptr == NULL:
            ustring_deinit(&path_str)
            raise ValueError("Failed to read ontology from path")

        ontology: Ontology = Ontology.__new__(Ontology)
        ontology.c_obj = ontology_ptr
        ustring_deinit(&path_str)
        return ontology

    def read_string(self, string: str):
        cdef UString string_str = pystr_to_ustring(string)
        cdef CowlAny *ontology_ptr = <CowlAny *> cowl_manager_read_string(<CowlManager *> self.c_obj, &string_str)

        if ontology_ptr == NULL:
            ustring_deinit(&string_str)
            raise ValueError("Failed to read ontology from string")

        ontology: Ontology = Ontology.__new__(Ontology)
        ontology.c_obj = ontology_ptr
        ustring_deinit(&string_str)
        return ontology

    def write_path(self, Ontology ontology, path: str):
        cdef UString string_str = pystr_to_ustring(path)
        cowl_manager_write_path(<CowlManager *> self.c_obj, <CowlOntology *> ontology.c_obj, string_str)
        ustring_deinit(&string_str)

    def write_str(self, Ontology ontology) -> str:
        cdef UStrBuf buffer = ustrbuf()
        cowl_manager_write_strbuf(<CowlManager *> self.c_obj, <CowlOntology *> ontology.c_obj, &buffer)
        cdef UString string = ustrbuf_to_ustring(&buffer)
        ret = ustring_to_pystr(&string)
        ustring_deinit(&string)
        return ret

    def new_ontology(self):
        ontology: Ontology = Ontology.__new__(Ontology)
        ontology.c_obj = cowl_manager_new_ontology(<CowlManager*>self.c_obj)
        return ontology

cdef class Ontology(Object):
    """
    Wrapper of ontology object. This is a stub now.
    The interface will need to be extended.
    """
    def __init__(self):
        raise ValueError("You cannot instantiate an ontology directly. Use Manager methods instead")

    def has_axiom(self, Axiom axiom, bint imports=True):
        return cowl_ontology_has_axiom(<CowlOntology*> self.c_obj, <CowlAnyAxiom*> axiom.c_obj, imports)

    def iterate_axioms(self, bint imports=True):
        if self.c_obj == NULL:
            raise ValueError("Ontologia non valida")

        cdef list results = []

        def callback(o):
            try:
                if o is not None:  # Controllo null
                    results.append(o)
                return True
            except Exception as e:
                print(f"Errore nel callback durante l'iterazione degli assiomi: {e}")
                return False
        cdef CowlIterator * it
        try:
            it_wrapper = Iterator(results, callback)
            it = it_wrapper.get_cowl_iterator()
            if it == NULL:
                raise ValueError("Impossibile creare l'iteratore")

            ret = cowl_ontology_iterate_axioms(<CowlOntology *> self.c_obj, it, imports)
            if not ret:
                print("Iterazione assiomi terminata prematuramente")

        except Exception as e:
            print(f"Errore durante l'iterazione degli assiomi: {e}")
            raise

        return results

    def iterate_axioms_of_type(self, CowlAxiomType type, bint imports=True):
        cdef list results = []
        def callback(o):
            results.append(o)
            return True

        it_wrapper = Iterator(results, callback)
        cdef CowlIterator* it = it_wrapper.get_cowl_iterator()
        if not cowl_ontology_iterate_axioms_of_type(<CowlOntology*> self.c_obj, type, it, imports):
            print("Axioms of type iteration finished")
        return results

    def iterate_axioms_of_types(self, CowlAxiomFlags flags, bint imports=True):
        cdef list results = []
        def callback(o):
            results.append(o)
            return True
        cdef CowlIterator* it

        try:
            it_wrapper = Iterator(results, callback)
            it = it_wrapper.get_cowl_iterator()
            if not cowl_ontology_iterate_axioms_of_types(<CowlOntology*> self.c_obj, flags, it, imports):
                print("Axioms of types iteration finished")
        except Exception as e:
            print(f"Error in iterate_axioms_of_types: {e}")
            raise
        return results

    def axiom_count(self, bint imports=True):
        return cowl_ontology_axiom_count(<CowlOntology*> self.c_obj, imports)

    def has_primitive(self, Primitive primitive, bint imports=True):
        return cowl_ontology_has_primitive(<CowlOntology*> self.c_obj, <CowlAnyPrimitive*> primitive.c_obj, imports)

    def iterate_primitives(self, CowlPrimitiveFlags flags, bint imports=True):
        cdef list results = []
        def callback(o):
            results.append(o)
            return True

        cdef CowlIterator* it

        try:
            it_wrapper = Iterator(results, callback)
            it = it_wrapper.get_cowl_iterator()
            if not cowl_ontology_iterate_primitives(<CowlOntology*> self.c_obj, flags, it, imports):
                print("Primitive iteration finished")
        except Exception as e:
            print(f"Error in iterate_primitives: {e}")
            raise
        return results

    def primitives_count(self, CowlPrimitiveFlags flags, bint imports=True):
        try:
            return cowl_ontology_primitives_count(<CowlOntology*> self.c_obj, flags, imports)
        except Exception as e:
            print(f"Error in primitives_count: {e}")
            raise

    def iterate_import_iris(self, bint imports=True):
        cdef list results = []
        def callback(o):
            results.append(o.get_iri())
            return True

        it_wrapper = Iterator(results, callback)
        cdef CowlIterator* it = it_wrapper.get_cowl_iterator()
        if not cowl_ontology_iterate_import_iris(<CowlOntology*> self.c_obj, it, imports):
            print("Imported IRIs iteration finished")
        return results

    def axiom_count_for_type(self, CowlAxiomType type, bint imports=True):
        return cowl_ontology_axiom_count_for_type(<CowlOntology*> self.c_obj, type, imports)

    def axiom_count_for_types(self, CowlAxiomFlags types, bint imports=True):
        return cowl_ontology_axiom_count_for_types(<CowlOntology*> self.c_obj, types, imports)

    def axiom_count_for_primitive(self, Primitive primitive, bint imports=True):
        return cowl_ontology_axiom_count_for_primitive(<CowlOntology*> self.c_obj, <CowlAnyPrimitive*> primitive.c_obj, imports)

    def iterate_axioms_for_primitive(self, Primitive primitive, bint imports=True):
        cdef list results = []
        def callback(o):
            results.append(o)
            return True

        it_wrapper = Iterator(results, callback)
        cdef CowlIterator* it = it_wrapper.get_cowl_iterator()
        if not cowl_ontology_iterate_axioms_for_primitive(<CowlOntology*> self.c_obj, <CowlAnyPrimitive*> primitive.c_obj, it, imports):
            print("Axioms for primitive iteration finished")
        return results

    def add_axiom(self, Axiom ax):
        cdef cowl_ret ret;

        ret = cowl_ontology_add_axiom(<CowlOntology*>self.c_obj, <CowlAnyAxiom*>ax.c_obj)
        return ret