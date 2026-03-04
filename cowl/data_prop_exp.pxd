from cowl.any cimport CowlAnyDataPropExp, CowlAny
from cowl.object cimport Object
from cowl.data_prop cimport CowlDataProp

cdef extern from "cowl_data_prop_exp.h":
    ctypedef struct CowlDataPropExp

    CowlDataProp *cowl_data_prop_exp_get_prop(CowlAnyDataPropExp *exp)

cdef class DataPropExp(Object):
    pass