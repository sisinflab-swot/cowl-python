from cowl.any cimport CowlAnyDataPropExp, CowlAnyIndividual
from cowl.vector cimport CowlVector
from cowl.literal cimport CowlLiteral
from cowl.individual cimport CowlIndividual
from cowl.axiom cimport Axiom
from cowl.data_prop_exp cimport CowlDataPropExp

cdef extern from "stdbool.h":
    ctypedef bint cbool_t "bool"

cdef extern from "cowl_data_prop_assert_axiom.h":
    ctypedef struct CowlDataPropAssertAxiom:
        pass

    CowlDataPropAssertAxiom *cowl_data_prop_assert_axiom(CowlAnyDataPropExp *prop, CowlAnyIndividual *subj, CowlLiteral *obj, CowlVector *annot)
    cbool_t cowl_data_prop_assert_axiom_is_negative(CowlDataPropAssertAxiom *axiom)
    CowlDataPropExp *cowl_data_prop_assert_axiom_get_prop(CowlDataPropAssertAxiom *axiom)
    CowlDataPropAssertAxiom* cowl_neg_data_prop_assert_axiom(
            CowlAnyDataPropExp *prop,
            CowlAnyIndividual *subj,
            CowlLiteral *obj,
            CowlVector *annot)
    CowlIndividual *cowl_data_prop_assert_axiom_get_subject(CowlDataPropAssertAxiom *axiom)
    CowlLiteral *cowl_data_prop_assert_axiom_get_object(CowlDataPropAssertAxiom *axiom)

cdef class DataPropAssertAxiom(Axiom):
    pass
