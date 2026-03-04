from cowl.any cimport CowlAnyAnnotValue, CowlAny

from cowl.object cimport Object
from cowl.annot_value_type cimport CowlAnnotValueType

cdef extern from "cowl_annot_value.h":
    ctypedef struct CowlAnnotValue:
        pass

    CowlAnnotValueType cowl_annot_value_get_type(CowlAnyAnnotValue* value)

cdef class AnnotValue(Object):
    pass
    #cdef CowlAny* c_obj
