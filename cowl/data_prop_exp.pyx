from cowl.object cimport Object, cowl_retain
from cowl.data_prop cimport DataProp

cdef class DataPropExp(Object):
    def __cinit__(self):
        self.c_obj = NULL

    def get_prop(self):
        cdef DataProp d = DataProp.__new__(DataProp)
        d.c_obj = cowl_data_prop_exp_get_prop(self.c_obj)
        cowl_retain(d.c_obj)
        return d