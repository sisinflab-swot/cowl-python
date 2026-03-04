from cowl.object cimport Object
from cowl.any cimport CowlAnyClsExp

cdef class ClsExp(Object):
    def get_type(self):
        return cowl_cls_exp_get_type(<CowlAnyClsExp*> self.c_obj)