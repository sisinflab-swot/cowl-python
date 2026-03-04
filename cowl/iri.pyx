from cowl.annot_value cimport AnnotValue
from cowl.object cimport cowl_retain
from cowl.string cimport String

cdef class IRI(AnnotValue):
    def get_ns(self):
        cdef String str = String.__new__(String)
        str.c_obj = cowl_iri_get_ns(<CowlIRI*>self.c_obj)
        cowl_retain(str.c_obj)
        return str

    def get_rem(self):
        cdef String str = String.__new__(String)
        str.c_obj = cowl_iri_get_rem(<CowlIRI*>self.c_obj)
        cowl_retain(str.c_obj)
        return str
