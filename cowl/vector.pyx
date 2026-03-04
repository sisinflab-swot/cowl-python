from cowl.object cimport cowl_release

cdef class Vector:
    def __init__(self):
        self.v = cowl_vector_empty()

    cdef cowl_vector_from_uvec(self, UVec_CowlObjectPtr* ptr):
        self.v = cowl_vector(ptr)

    def __dealloc__(self):
        if self.v != NULL:
            cowl_release(self.v)