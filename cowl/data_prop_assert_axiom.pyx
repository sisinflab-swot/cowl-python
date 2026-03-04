from cowl.any cimport CowlAnyAxiom, CowlAny

from cowl.individual cimport Individual, CowlIndividual
from cowl.literal cimport Literal, CowlLiteral
from cowl.axiom cimport Axiom, cowl_axiom_get_annot
from cowl.data_prop_exp cimport DataPropExp, CowlDataPropExp
from cowl.object cimport cowl_retain, cowl_release
from cowl.vector cimport cowl_vector_empty, Vector

cdef class DataPropAssertAxiom(Axiom):
    def __init__(self, DataPropExp prop, Individual subj, Literal obj, Vector annot):
        if annot.v == NULL:
            annot.v = cowl_vector_empty()
        else:
            cowl_retain(annot.v)

        try:
            self.c_obj = cowl_data_prop_assert_axiom(
                prop.c_obj,
                subj.c_obj,
                <CowlLiteral *> obj.c_obj,
                annot.v
            )
        except Exception as e:
            print(f"[ERROR] Python-level exception calling cowl_data_prop_assert_axiom(): {e}")
            raise
        except:
            print("[ERROR] Fatal error occurred while calling cowl_data_prop_assert_axiom() (possible segfault)")
            raise

    def is_negative(self):
        if self.c_obj == NULL:
            raise ValueError("DataPropAssertAxiom non inizializzato")
        return cowl_data_prop_assert_axiom_is_negative(<CowlDataPropAssertAxiom *>self.c_obj)

    def get_prop(self):
        if self.c_obj == NULL:
            raise ValueError("DataPropAssertAxiom non inizializzato")
        cdef DataPropExp dpe = DataPropExp.__new__(DataPropExp)
        dpe.c_obj = cowl_data_prop_assert_axiom_get_prop(<CowlDataPropAssertAxiom *>self.c_obj)
        cowl_retain(<CowlAny*> dpe.c_obj)
        return dpe

    def make_negative(self):
        cdef CowlDataPropAssertAxiom *c_axiom;
        cdef CowlDataPropExp *prop;
        cdef CowlIndividual *subj;
        cdef CowlLiteral *obj;
        cdef CowlVector *annot;
        cdef CowlDataPropAssertAxiom *neg_axiom;
        cdef CowlDataPropAssertAxiom *old_axiom;
        try:
            if self.c_obj == NULL:
                raise ValueError("make_negative(): DataPropAssertAxiom non inizializzato")

            c_axiom = <CowlDataPropAssertAxiom *> self.c_obj
            prop = <CowlDataPropExp*> cowl_data_prop_assert_axiom_get_prop(c_axiom)
            subj = <CowlIndividual*> cowl_data_prop_assert_axiom_get_subject(c_axiom)
            obj = <CowlLiteral*> cowl_data_prop_assert_axiom_get_object(c_axiom)
            annot = <CowlVector*> cowl_axiom_get_annot(<CowlAnyAxiom *> c_axiom)

            if annot == NULL:
                annot = cowl_vector_empty()
            else:
                cowl_retain(annot)

            old_axiom = <CowlDataPropAssertAxiom *> self.c_obj

            # Verifica parametri essenziali
            if prop == NULL:
                raise ValueError("make_negative(): parametri non validi (prop NULL)")
            if subj == NULL:
                raise ValueError("make_negative(): parametri non validi (subj NULL)")
            if obj == NULL:
                raise ValueError("make_negative(): parametri non validi (obj NULL)")

            cowl_retain(prop)
            cowl_retain(subj)
            cowl_retain(obj)

            neg_axiom = cowl_neg_data_prop_assert_axiom(prop, subj, obj, annot)
            if neg_axiom == NULL:
                raise MemoryError("make_negative(): cowl_neg_data_prop_assert_axiom ha restituito NULL")

            self.c_obj = neg_axiom

            cowl_release(old_axiom)

            cowl_release(prop)
            cowl_release(subj)
            cowl_release(obj)
            cowl_release(annot)

        except Exception:
            raise

    def get_negative(self):
        cdef CowlDataPropExp* prop_obj
        cdef CowlIndividual* subj_obj
        cdef CowlLiteral* obj_obj
        cdef CowlVector* annot
        cdef CowlDataPropAssertAxiom *neg_axiom
        cdef DataPropAssertAxiom d = DataPropAssertAxiom.__new__(DataPropAssertAxiom)

        try:
            if self.c_obj == NULL:
                raise ValueError("get_negative(): DataPropAssertAxiom non inizializzato")

            prop_obj = cowl_data_prop_assert_axiom_get_prop(<CowlDataPropAssertAxiom *> self.c_obj)
            subj_obj = cowl_data_prop_assert_axiom_get_subject(<CowlDataPropAssertAxiom *> self.c_obj)
            obj_obj = cowl_data_prop_assert_axiom_get_object(<CowlDataPropAssertAxiom *> self.c_obj)
            annot = <CowlVector *> cowl_axiom_get_annot(<CowlAnyAxiom *> self.c_obj)

            # Verifica parametri essenziali
            if prop_obj == NULL:
                raise ValueError("get_negative(): parametri non validi (prop NULL)")
            if subj_obj == NULL:
                raise ValueError("get_negative(): parametri non validi (subj NULL)")
            if obj_obj == NULL:
                raise ValueError("get_negative(): parametri non validi (obj NULL)")

            if annot == NULL:
                annot = cowl_vector_empty()
            else:
                cowl_retain(annot)

            cowl_retain(prop_obj)
            cowl_retain(subj_obj)
            cowl_retain(obj_obj)

            neg_axiom = cowl_neg_data_prop_assert_axiom(
                <CowlAnyDataPropExp *> prop_obj,
                <CowlAnyIndividual *> subj_obj,
                <CowlLiteral *> obj_obj,
                <CowlVector *> annot
            )

            if neg_axiom == NULL:
                raise MemoryError("get_negative(): cowl_neg_data_prop_assert_axiom ha restituito NULL")

            d.c_obj = neg_axiom

            cowl_release(annot)
            cowl_release(prop_obj)
            cowl_release(subj_obj)
            cowl_release(obj_obj)

            return d

        except Exception as e:
            print(f"[ERRORE] in get_negative: {e}")
            raise

    def get_subject(self):
        if self.c_obj == NULL:
            raise ValueError("DataPropAssertAxiom non inizializzato")
        cdef Individual ind = Individual.__new__(Individual)
        ind.c_obj = cowl_data_prop_assert_axiom_get_subject(<CowlDataPropAssertAxiom *>self.c_obj)
        cowl_retain(<CowlAny*> ind.c_obj)
        return ind

    def get_object(self):
        if self.c_obj == NULL:
            raise ValueError("DataPropAssertAxiom non inizializzato")
        cdef Literal l = Literal.__new__(Literal)
        l.c_obj = cowl_data_prop_assert_axiom_get_object(<CowlDataPropAssertAxiom *>self.c_obj)
        cowl_retain(<CowlAny*> l.c_obj)
        return l

    def whoami(self):
        print("DataPropAssertAxiom")