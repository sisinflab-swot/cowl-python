from cowl.any cimport CowlAny
from cowl.vector cimport UVec_CowlObjectPtr
from cowl.object_type cimport CowlObjectType

from libc.stdint cimport uintptr_t

cdef extern from "cowl_iterator.h":
    # Puntatore a CowlObject
    ctypedef CowlAny* CowlObjectPtr

    # Forward declaration di UHash
    ctypedef struct UHash_CowlObjectTable

    # Struttura C che rappresenta un iteratore
    ctypedef struct CowlIterator:
        void* ctx
        bint (*for_each)(void* ctx, CowlAny* object)

    # Funzioni C esposte dalla libreria
    CowlIterator cowl_iterator_vec(UVec_CowlObjectPtr* vec, bint retain)
    CowlIterator cowl_iterator_set(UHash_CowlObjectTable* set, bint retain)
    CowlIterator cowl_iterator_count(uintptr_t* count)
    CowlIterator cowl_iterator_contains(CowlAny* object)

# Classe Python che wrappa CowlIterator
cdef class Iterator:
    cdef CowlIterator it
    cdef object pylist
    cdef object callback
    cdef CowlIterator* get_cowl_iterator(self)
