"""Forward declaration"""

from cowl.string cimport CowlString

cdef extern from "cowl_iri.h":
    # This is a forward declaration of a C struct
    # You can see that it is missing internal fields
    # This is because we do not need to access those.
    # We only need the ability of declaring new structs (or references to the struct)
    # and pass them to C functions

    ctypedef struct CowlIRI

    #CowlIRI* cowl_iri(CowlString* prefix, CowlString* suffix)
    #CowlIRI* cowl_iri_from_string(UString string)
    CowlString* cowl_iri_get_ns(CowlIRI* iri)
    CowlString* cowl_iri_get_rem(CowlIRI* iri)
    #bint cowl_iri_is_reserved(CowlIRI* iri)
    #bint cowl_iri_has_rem(CowlIRI* iri)
