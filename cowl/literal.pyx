from cowl.datatype cimport Datatype, CowlDatatype
from cowl.object cimport cowl_retain

cdef class Literal(AnnotValue):
    def get_datatype(self):
        cdef Datatype dt = Datatype()
        dt.c_obj = <CowlDatatype*>cowl_literal_get_datatype(<CowlLiteral*>self.c_obj)
        cowl_retain(dt.c_obj)
        return dt