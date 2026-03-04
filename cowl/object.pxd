"""
Define and implement the CowlObject type in Cython/Python (cdef class Object)
Also forward the required functions from cowl.h
"""

from cowl.ulib cimport UString
from cowl.any cimport CowlAny
from cowl.string cimport CowlString
from cowl.vector cimport CowlVector
from cowl.object_type cimport CowlObjectType
from cowl.error_handler cimport CowlErrorHandler, ErrorHandler
from libc.stdint cimport uintptr_t

cdef extern from "cowl.h":

    ctypedef struct CowlObject:
        pass

    ctypedef struct CowlIRI:
        pass

    void cowl_init()
    CowlAny* cowl_retain(CowlAny* object)
    void cowl_release(CowlAny* object)
    CowlObjectType cowl_get_type(CowlAny* object)
    bint cowl_is_primitive(CowlAny* object)
    bint cowl_is_entity(CowlAny* object)
    bint cowl_is_axiom(CowlAny* object)
    bint cowl_is_cls_exp(CowlAny* object)
    bint cowl_is_obj_prop_exp(CowlAny* object)
    bint cowl_is_data_prop_exp(CowlAny* object)
    bint cowl_is_individual(CowlAny* object)
    bint cowl_is_data_range(CowlAny* object)
    CowlIRI* cowl_get_iri(CowlAny* object)
    CowlString* cowl_get_ns(CowlAny* object)
    CowlString* cowl_get_rem(CowlAny* object)
    CowlVector* cowl_get_annot(CowlAny* object)
    CowlString* cowl_to_string(CowlAny* object)
    CowlString* cowl_to_debug_string(CowlAny* object)
    bint cowl_equals(CowlAny* lhs, CowlAny* rhs)
    bint cowl_equals_iri_string(CowlAny* object, UString iri_str)
    bint cowl_is_reserved(CowlAny* object)
    uintptr_t cowl_hash(CowlAny* object)
    void cowl_set_error_handler(CowlErrorHandler handler)
    #bint cowl_iterate_primitives(CowlAny* object, CowlPrimitiveFlags flags, CowlIterator* iter)

cdef ErrorHandler global_handler

cpdef inline pycowl_init():
    cowl_init()
    cowl_set_error_handler(global_handler.eh)

cdef class Object:
    cdef CowlAny* c_obj
