from cowl.axiom_type cimport CowlAxiomType
from cowl.any cimport CowlAnyAxiom
from cowl.vector cimport CowlVector
from cowl.object cimport Object

cdef extern from "cowl_axiom.h":
    # This is a forward declaration of a C struct
    # You can see that it is missing internal fields
    # This is because we do not need to access those.
    # We only need the ability of declaring new structs (or references to the struct)
    # and pass them to C functions

    ctypedef struct CowlAxiom: 
        pass

    CowlAxiomType cowl_axiom_get_type(CowlAnyAxiom *axiom)
    CowlVector* cowl_axiom_get_annot(CowlAnyAxiom *axiom)

cdef class Axiom(Object):
    pass