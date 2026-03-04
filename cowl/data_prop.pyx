from cowl.object cimport cowl_retain
from cowl.iri cimport IRI, CowlIRI

cdef class DataProp:
    def __init__(self, IRI i):
        self.c_obj = <CowlDataProp*>cowl_data_prop(<CowlIRI*>i.c_obj)
        cowl_retain(self.c_obj)

    cdef get_iri(self):
        cdef IRI i = IRI.__new__(IRI)
        i.c_obj = <CowlIRI*> cowl_data_prop_get_iri(<CowlDataProp*> self.c_obj)
        if i.c_obj == NULL:
            raise ValueError("IRI object not valid")

        cowl_retain(i.c_obj)
        return i