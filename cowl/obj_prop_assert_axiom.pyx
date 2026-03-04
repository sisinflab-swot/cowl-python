from cowl.axiom cimport Axiom, cowl_axiom_get_annot
from cowl.any cimport CowlAnyAxiom
from cowl.vector cimport CowlVector
from cowl.obj_prop_exp cimport ObjPropExp
from cowl.individual cimport Individual
from cowl.object cimport cowl_retain, cowl_release
from cowl.vector cimport cowl_vector_empty, Vector

cdef class ObjPropAssertAxiom(Axiom):
    def __init__(self, ObjPropExp prop, Individual subj, Individual obj, Vector annot):
        if annot.v == NULL:
            annot.v = cowl_vector_empty()

        self.c_obj = cowl_obj_prop_assert_axiom(prop.c_obj, subj.c_obj, obj.c_obj, annot.v)

    def make_positive(self):
        cdef CowlObjPropAssertAxiom *c_axiom;
        cdef CowlObjPropExp *prop;
        cdef CowlIndividual *subj;
        cdef CowlIndividual *obj;
        cdef CowlVector *annot;
        cdef CowlObjPropAssertAxiom *pos_axiom;
        cdef CowlObjPropAssertAxiom *old_axiom;
        try:
            if self.c_obj == NULL:
                raise ValueError("make_positive(): ObjPropAssertAxiom non inizializzato")
       
            c_axiom = <CowlObjPropAssertAxiom *> self.c_obj
            prop = <CowlObjPropExp*> cowl_obj_prop_assert_axiom_get_prop(c_axiom)
            subj = <CowlIndividual*> cowl_obj_prop_assert_axiom_get_subject(c_axiom)
            obj = <CowlIndividual*> cowl_obj_prop_assert_axiom_get_object(c_axiom)
            annot = <CowlVector*> cowl_axiom_get_annot(<CowlAnyAxiom *> c_axiom)

            # Verifica parametri essenziali
            if prop == NULL:
                raise ValueError("make_positive(): parametri non validi (prop NULL)")
            if subj == NULL:
                raise ValueError("make_positive(): parametri non validi (subj NULL)")
            if obj == NULL:
                raise ValueError("make_positive(): parametri non validi (obj NULL)")

            if annot == NULL:
                annot = cowl_vector_empty()
            else:
                cowl_retain(annot)

            pos_axiom = <CowlObjPropAssertAxiom*> cowl_obj_prop_assert_axiom(prop, subj, obj, annot)
            if pos_axiom == NULL:
                raise MemoryError("make_positive(): cowl_obj_prop_assert_axiom ha restituito NULL")

            self.c_obj = pos_axiom
            cowl_release(c_axiom)
        except Exception:
            raise 

    def get_negative(self):
        cdef CowlObjPropAssertAxiom *c_axiom
        cdef CowlObjPropExp *prop_obj
        cdef CowlIndividual *subj_obj
        cdef CowlIndividual *obj_obj
        cdef CowlVector *annot
        cdef CowlObjPropAssertAxiom *neg_axiom
        cdef ObjPropAssertAxiom o = ObjPropAssertAxiom.__new__(ObjPropAssertAxiom)

        try:
            if self.c_obj == NULL:
                raise ValueError("get_negative(): ObjPropAssertAxiom non inizializzato")

            c_axiom = <CowlObjPropAssertAxiom *> self.c_obj
            prop_obj = <CowlObjPropExp*> cowl_obj_prop_assert_axiom_get_prop(c_axiom)
            subj_obj = <CowlIndividual*> cowl_obj_prop_assert_axiom_get_subject(c_axiom)
            obj_obj = <CowlIndividual*> cowl_obj_prop_assert_axiom_get_object(c_axiom)
            annot = <CowlVector *> cowl_axiom_get_annot(<CowlAnyAxiom *> c_axiom)
            
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

            neg_axiom = cowl_neg_obj_prop_assert_axiom(prop_obj, subj_obj, obj_obj, annot)

            if neg_axiom == NULL:
                raise MemoryError("get_negative(): cowl_neg_obj_prop_assert_axiom ha restituito NULL")

            o.c_obj = neg_axiom

            cowl_release(annot)
            cowl_release(prop_obj)
            cowl_release(subj_obj)
            cowl_release(obj_obj)

            return o

        except Exception as e:
            print(f"[ERRORE] in get_negative: {e}")
            raise

    def make_negative(self):
        cdef CowlObjPropAssertAxiom *c_axiom
        cdef CowlObjPropExp *prop
        cdef CowlIndividual *subj
        cdef CowlIndividual *obj
        cdef CowlVector *annot
        cdef CowlObjPropAssertAxiom *neg_axiom
        cdef CowlObjPropAssertAxiom *old_axiom
        try:
            if self.c_obj == NULL:
                raise ValueError("make_negative():ObjPropAssertAxiom non inizializzato")
       
            c_axiom = <CowlObjPropAssertAxiom *> self.c_obj
            prop = <CowlObjPropExp*> cowl_obj_prop_assert_axiom_get_prop(c_axiom)
            subj = <CowlIndividual*> cowl_obj_prop_assert_axiom_get_subject(c_axiom)
            obj = <CowlIndividual*> cowl_obj_prop_assert_axiom_get_object(c_axiom)
            annot = <CowlVector*> cowl_axiom_get_annot(<CowlAnyAxiom *> c_axiom)
            old_axiom = <CowlObjPropAssertAxiom *> self.c_obj

            # Verifica parametri essenziali
            if prop == NULL:
                raise ValueError("make_negative(): parametri non validi (prop NULL)")
            if subj == NULL:
                raise ValueError("make_negative(): parametri non validi (subj NULL)")
            if obj == NULL:
                raise ValueError("make_negative(): parametri non validi (obj NULL)")

            if annot == NULL:
                annot = cowl_vector_empty()
            else:
                cowl_retain(annot)

            cowl_retain(prop)
            cowl_retain(subj)
            cowl_retain(obj)

            neg_axiom = <CowlObjPropAssertAxiom*> cowl_neg_obj_prop_assert_axiom(prop, subj, obj, annot)
            if neg_axiom == NULL:
                raise MemoryError("make_negative(): cowl_obj_prop_assert_axiom ha restituito NULL")

            self.c_obj = neg_axiom

            cowl_release(old_axiom)
            cowl_release(annot)
            cowl_release(prop)
            cowl_release(subj)
            cowl_release(obj)
        
        except Exception as e:
            print(f"[ERRORE] in make_negative: {e}")
            raise

    def is_negative(self):
        if self.c_obj == NULL:
            raise ValueError("is_negative(): ObjPropAssertAxiom non inizializzato")
        return cowl_obj_prop_assert_axiom_is_negative(<CowlObjPropAssertAxiom*>self.c_obj)

    def get_prop(self):
        if self.c_obj == NULL:
            raise ValueError("get_prop(): ObjPropAssertAxiom non inizializzato")
        cdef ObjPropExp prop = ObjPropExp.__new__(ObjPropExp)
        prop.c_obj = cowl_obj_prop_assert_axiom_get_prop(<CowlObjPropAssertAxiom*>self.c_obj)
        cowl_retain(prop.c_obj)
        return prop
    
    def get_subject(self):
        if self.c_obj == NULL:
            raise ValueError("get_subject(): ObjPropAssertAxiom non inizializzato")
        cdef Individual subj = Individual.__new__(Individual)
        subj.c_obj = cowl_obj_prop_assert_axiom_get_subject(<CowlObjPropAssertAxiom*>self.c_obj)
        cowl_retain(subj.c_obj)
        return subj
    
    def get_object(self):
        if self.c_obj == NULL:
            raise ValueError("get_object(): ObjPropAssertAxiom non inizializzato")
        cdef Individual obj = Individual.__new__(Individual)
        obj.c_obj = cowl_obj_prop_assert_axiom_get_object(<CowlObjPropAssertAxiom*>self.c_obj)
        cowl_retain(obj.c_obj)
        return obj
    
    def whoami(self):
        print("ObjPropAssertAxiom")
