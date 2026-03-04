"""Forward declaration"""

from cowl.any cimport CowlAny
from cowl.vector cimport UVec_CowlObjectPtr
from cowl.object_type cimport CowlObjectType

from libc.stdint cimport uintptr_t

cdef extern from "cowl_iterator.h":

    # Define the CowlObjectPtr type
    ctypedef CowlAny* CowlObjectPtr

    # Forward declaration of UHash for CowlObjectTable
    ctypedef struct UHash_CowlObjectTable

    # Define CowlIterator struct
    # In this typedef struct we explictly define the internal
    # variables (that MUST match C's in both order and type)
    # since we will need to access those from cython
    ctypedef struct CowlIterator:
        void* ctx
        bint (*for_each)(void* ctx, CowlAny* object)

    # Function declarations
    CowlIterator cowl_iterator_vec(UVec_CowlObjectPtr* vec, bint retain)
    CowlIterator cowl_iterator_set(UHash_CowlObjectTable* set, bint retain)
    CowlIterator cowl_iterator_count(uintptr_t* count)
    CowlIterator cowl_iterator_contains(CowlAny* object)

