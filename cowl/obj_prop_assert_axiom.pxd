from cowl.axiom cimport Axiom
from cowl.any cimport CowlAnyObjPropExp, CowlAnyIndividual
from cowl.vector cimport CowlVector
from cowl.individual cimport CowlIndividual
from cowl.obj_prop_exp cimport CowlObjPropExp

cdef extern from "cowl_obj_prop_assert_axiom.h":
    ctypedef struct CowlObjPropAssertAxiom:
        pass
    
    CowlObjPropAssertAxiom *cowl_obj_prop_assert_axiom(CowlAnyObjPropExp *prop, CowlAnyIndividual *subject, CowlAnyIndividual *object, CowlVector *annot)
    CowlObjPropAssertAxiom *cowl_neg_obj_prop_assert_axiom(CowlAnyObjPropExp *prop, CowlAnyIndividual *subject, CowlAnyIndividual *object, CowlVector *annot)
    bint cowl_obj_prop_assert_axiom_is_negative(CowlObjPropAssertAxiom *axiom)
    CowlObjPropExp *cowl_obj_prop_assert_axiom_get_prop(CowlObjPropAssertAxiom *axiom)
    CowlIndividual *cowl_obj_prop_assert_axiom_get_subject(CowlObjPropAssertAxiom *axiom)
    CowlIndividual *cowl_obj_prop_assert_axiom_get_object(CowlObjPropAssertAxiom *axiom)

cdef class ObjPropAssertAxiom(Axiom):
    pass