from cowl.any cimport CowlAnyPrimitive

cdef class Primitive(Object):

    def get_type(self):
        return cowl_primitive_get_type(<CowlAnyPrimitive*> self.c_obj)