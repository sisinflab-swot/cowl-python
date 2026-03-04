from cowl.object cimport Object

cdef extern from "cowl_data_range.h":
    ctypedef struct CowlDataRange

cdef class DataRange(Object):
    pass