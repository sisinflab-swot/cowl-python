from cowl.primitive cimport Primitive
from cowl.any cimport CowlAnyEntity

cdef class Entity(Primitive):
    def get_type(self):
        return cowl_entity_get_type(<CowlAnyEntity*> self.c_obj)