from cowl.object cimport Object
from cowl.any cimport CowlAnyClsExp
from cowl.cls_exp_type cimport CowlClsExpType

cdef extern from "cowl_cls_exp.h":
    ctypedef struct CowlClsExp:
        pass

    CowlClsExpType cowl_cls_exp_get_type(CowlAnyClsExp *exp)

cdef class ClsExp(Object):
    pass