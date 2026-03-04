from cowl.primitive cimport Primitive
from cowl.entity_type cimport CowlEntityType
from cowl.any cimport CowlAnyEntity

cdef extern from "cowl_entity.h":
    ctypedef struct CowlEntity:
        pass
    
    CowlEntityType cowl_entity_get_type(CowlAnyEntity *entity)

cdef class Entity(Primitive):
    pass