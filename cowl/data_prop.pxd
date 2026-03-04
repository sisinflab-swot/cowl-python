from cowl.iri cimport CowlIRI
from cowl.data_prop_exp cimport DataPropExp

cdef extern from "cowl_data_prop.h":
    ctypedef struct CowlDataProp

    CowlDataProp *cowl_data_prop(CowlIRI *iri)
    #CowlDataProp *cowl_data_prop_from_string(UString string)
    CowlIRI *cowl_data_prop_get_iri(CowlDataProp *prop)

cdef class DataProp:
    cdef CowlDataProp* c_obj
    cdef get_iri(self)