from cowl.axiom cimport Axiom, CowlAxiom, cowl_axiom_get_annot
from cowl.any cimport CowlAny, CowlAnyAxiom
from cowl.cls_exp cimport ClsExp
from cowl.vector cimport CowlVector, cowl_vector_empty, Vector
from cowl.object cimport cowl_retain

cdef class SubClsAxiom(Axiom):
    def __init__(self, ClsExp sub, ClsExp sup, Vector annot):
        if annot.v == NULL:
            annot.v = cowl_vector_empty()

        self.c_obj = cowl_sub_cls_axiom(sub.c_obj, sup.c_obj, annot.v)

    def get_sub(self):
        if self.c_obj == NULL:
            raise ValueError("SubClsAxiom non inizializzato")
        cdef ClsExp cls = ClsExp.__new__(ClsExp)
        cls.c_obj = <CowlAny*> cowl_sub_cls_axiom_get_sub(<CowlSubClsAxiom*>self.c_obj)
        cowl_retain(cls.c_obj)
        return cls

    def get_super(self):
        if self.c_obj == NULL:
            raise ValueError("SubClsAxiom non inizializzato")
        cdef ClsExp cls = ClsExp.__new__(ClsExp)
        cls.c_obj = <CowlAny*> cowl_sub_cls_axiom_get_super(<CowlSubClsAxiom*> self.c_obj)
        cowl_retain(cls.c_obj)
        return cls
    
    def whoami(self):
        print("SubClsAxiom")