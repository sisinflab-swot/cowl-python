cdef class String:
    def __cinit__(self):
        self.c_obj = NULL