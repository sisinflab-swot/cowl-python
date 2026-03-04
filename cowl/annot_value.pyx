from cowl.any cimport CowlAnyAnnotValue

cdef class AnnotValue(Object):
    def get_type(self):
        return cowl_annot_value_get_type(<CowlAnyAnnotValue*>self.c_obj)