from cowl.any cimport CowlAnyIndividual
from cowl.primitive cimport Primitive

cdef extern from "stdbool.h":
    ctypedef bint cbool_t "bool"

cdef extern from "cowl_individual.h":
    ctypedef struct CowlIndividual:
        pass

    cbool_t cowl_individual_is_named(CowlAnyIndividual *ind)

cdef class Individual(Primitive):
    pass