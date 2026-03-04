from cowl.object cimport Object

cdef class ObjPropExp(Object):
    def __cinit__(self):
        self.c_obj = NULL