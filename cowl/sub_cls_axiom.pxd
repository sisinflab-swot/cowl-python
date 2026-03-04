from cowl.axiom cimport Axiom
from cowl.any cimport CowlAnyClsExp
from cowl.cls_exp cimport CowlClsExp
from cowl.vector cimport CowlVector

cdef extern from "cowl_sub_cls_axiom.h":
    ctypedef struct CowlSubClsAxiom:
        pass

    CowlSubClsAxiom *cowl_sub_cls_axiom(CowlAnyClsExp *sub, CowlAnyClsExp *super, CowlVector *annot)
    CowlClsExp *cowl_sub_cls_axiom_get_sub(CowlSubClsAxiom *axiom)
    CowlClsExp *cowl_sub_cls_axiom_get_super(CowlSubClsAxiom *axiom)

cdef class SubClsAxiom(Axiom):
    pass