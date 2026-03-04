from cowl.object cimport Object

cdef extern from "cowl_obj_prop_exp.h":
    ctypedef struct CowlObjPropExp:
        pass

cdef class ObjPropExp(Object):
    pass