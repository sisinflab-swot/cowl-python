from cowl.data_range cimport DataRange
from cowl.iri cimport IRI, CowlIRI
from cowl.ulib cimport pystr_to_ustring

cdef class Datatype(DataRange):
    def __init__(self, IRI i):
        if i.c_obj == NULL:
            self.c_obj = NULL
        else:
            self.c_obj = cowl_datatype(<CowlIRI*>i.c_obj)

    def init_from_string(self, str ustr):
        self.c_obj = cowl_datatype_from_string(pystr_to_ustring(ustr))