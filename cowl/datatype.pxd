from cowl.object cimport CowlIRI
from cowl.ulib cimport UString
from cowl.data_range cimport DataRange

cdef extern from "cowl_datatype.h":
    ctypedef struct CowlDatatype:
        pass

    CowlDatatype *cowl_datatype(CowlIRI *iri)
    CowlDatatype *cowl_datatype_from_string(UString string)

cdef class Datatype(DataRange):
    pass