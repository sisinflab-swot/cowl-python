from cowl.axiom cimport Axiom, CowlAxiom, cowl_axiom_get_annot
from cowl.cls_exp cimport ClsExp
from cowl.individual cimport Individual
from cowl.any cimport CowlAny
from cowl.vector cimport cowl_vector_empty, Vector
from cowl.object cimport cowl_retain

cdef class ClsAssertAxiom(Axiom):
    def __init__(self, ClsExp exp, Individual ind, Vector annot):
        if annot.v == NULL:
            annot.v = cowl_vector_empty()

        self.c_obj = cowl_cls_assert_axiom(exp.c_obj, ind.c_obj, annot.v)

    def get_cls_exp(self):
        if self.c_obj == NULL:
            raise ValueError("ClsAssertAxiom non inizializzato")
        cdef ClsExp cls = ClsExp.__new__(ClsExp)
        cls.c_obj = <CowlAny*> cowl_cls_assert_axiom_get_cls_exp(<CowlClsAssertAxiom*>self.c_obj)
        cowl_retain(cls.c_obj)
        return cls
    
    def get_ind(self):
        if self.c_obj == NULL:
            raise ValueError("Indivisual non inizializzato")
        cdef Individual ind = Individual.__new__(Individual)
        ind.c_obj = <CowlAny*> cowl_cls_assert_axiom_get_ind(<CowlClsAssertAxiom*>self.c_obj)
        cowl_retain(ind.c_obj)
        return ind

    def whoami(self):
        print("ClsAssertAxiom")