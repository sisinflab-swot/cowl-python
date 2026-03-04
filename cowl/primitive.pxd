from cowl.primitive_type cimport CowlPrimitiveType
from cowl.any cimport CowlAnyPrimitive
from cowl.object cimport Object

cdef extern from "cowl_primitive.h":
    ctypedef struct CowlPrimitive:
        pass
    
    CowlPrimitiveType cowl_primitive_get_type(CowlAnyPrimitive *primitive)

cdef class Primitive(Object):
    pass