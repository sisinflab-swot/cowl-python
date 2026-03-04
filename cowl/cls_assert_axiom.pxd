from cowl.axiom cimport Axiom
from cowl.cls_exp cimport CowlClsExp
from cowl.any cimport CowlAnyClsExp, CowlAnyIndividual
from cowl.individual cimport CowlIndividual
from cowl.vector cimport CowlVector

cdef extern from "cowl_cls_assert_axiom.h":
    ctypedef struct CowlClsAssertAxiom:
        pass

    CowlClsAssertAxiom *cowl_cls_assert_axiom(CowlAnyClsExp *exp, CowlAnyIndividual *ind, CowlVector *annot)
    CowlClsExp *cowl_cls_assert_axiom_get_cls_exp(CowlClsAssertAxiom *axiom)
    CowlIndividual *cowl_cls_assert_axiom_get_ind(CowlClsAssertAxiom *axiom)

cdef class ClsAssertAxiom(Axiom):
    pass