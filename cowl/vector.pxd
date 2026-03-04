"""Forward declarations"""
# cowl/vector.pxd

from cowl.any cimport CowlAny
from libc.stdint cimport uintptr_t

cdef extern from "cowl_vector.h":

    # Forward declare the CowlVector struct
    ctypedef struct CowlVector
    ctypedef CowlAny* CowlObjectPtr
    ctypedef struct UVec_CowlObjectPtr

    #CowlVector* cowl_vector(UVec_CowlObjectPtr* vec)
    #CowlVector* cowl_vector_empty()
    #UVec(CowlObjectPtr) *cowl_vector_get_data(CowlVector* vec)
    #uintptr_t cowl_vector_count(CowlVector* vec)
    #CowlAny* cowl_vector_get_item(CowlVector* vec, ulib_uint idx)
    #bint cowl_vector_contains(CowlVector* vec, CowlAny* object)

