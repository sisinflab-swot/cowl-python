# cowl/iri.pxd
from cowl.string cimport CowlString
from cowl.object cimport CowlIRI
from cowl.annot_value cimport AnnotValue

cdef extern from "cowl_iri.h":
    CowlString* cowl_iri_get_ns(CowlIRI* iri)
    CowlString* cowl_iri_get_rem(CowlIRI* iri)

cdef class IRI(AnnotValue):
    pass