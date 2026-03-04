"""Forward declarations"""

from cowl.axiom_type cimport CowlAxiomType

cdef extern from "cowl_axiom_flags.h":
    
	ctypedef unsigned char CowlAxiomFlags

	CowlAxiomFlags COWL_AF_NONE
	CowlAxiomFlags COWL_AF_ALL
	CowlAxiomFlags COWL_AF_DECL
	CowlAxiomFlags COWL_AF_SUB_CLASS
	CowlAxiomFlags COWL_AF_EQUIV_CLASSES
	CowlAxiomFlags COWL_AF_DISJ_CLASSES
	CowlAxiomFlags COWL_AF_DISJ_UNION
	CowlAxiomFlags COWL_AF_SUB_OBJ_PROP
	CowlAxiomFlags COWL_AF_EQUIV_OBJ_PROP
	CowlAxiomFlags COWL_AF_DISJ_OBJ_PROP
	CowlAxiomFlags COWL_AF_INV_OBJ_PROP
	CowlAxiomFlags COWL_AF_OBJ_PROP_DOMAIN
	CowlAxiomFlags COWL_AF_OBJ_PROP_RANGE
	CowlAxiomFlags COWL_AF_FUNC_OBJ_PROP
	CowlAxiomFlags COWL_AF_INV_FUNC_OBJ_PROP
	CowlAxiomFlags COWL_AF_REFL_OBJ_PROP
	CowlAxiomFlags COWL_AF_IRREFL_OBJ_PROP
	CowlAxiomFlags COWL_AF_SYMM_OBJ_PROP
	CowlAxiomFlags COWL_AF_ASYMM_OBJ_PROP
	CowlAxiomFlags COWL_AF_TRANS_OBJ_PROP
	CowlAxiomFlags COWL_AF_SUB_DATA_PROP
	CowlAxiomFlags COWL_AF_EQUIV_DATA_PROP
	CowlAxiomFlags COWL_AF_DISJ_DATA_PROP
	CowlAxiomFlags COWL_AF_DATA_PROP_DOMAIN
	CowlAxiomFlags COWL_AF_DATA_PROP_RANGE
	CowlAxiomFlags COWL_AF_FUNC_DATA_PROP
	CowlAxiomFlags COWL_AF_DATATYPE_DEF
	CowlAxiomFlags COWL_AF_HAS_KEY
	CowlAxiomFlags COWL_AF_SAME_IND
	CowlAxiomFlags COWL_AF_DIFF_IND
	CowlAxiomFlags COWL_AF_CLASS_ASSERT
	CowlAxiomFlags COWL_AF_OBJ_PROP_ASSERT
	CowlAxiomFlags COWL_AF_NEG_OBJ_PROP_ASSERT
	CowlAxiomFlags COWL_AF_DATA_PROP_ASSERT
	CowlAxiomFlags COWL_AF_NEG_DATA_PROP_ASSERT
	CowlAxiomFlags COWL_AF_ANNOT_ASSERT
	CowlAxiomFlags COWL_AF_SUB_ANNOT_PROP
	CowlAxiomFlags COWL_AF_ANNOT_PROP_DOMAIN
	CowlAxiomFlags COWL_AF_ANNOT_PROP_RANGE

	CowlAxiomFlags cowl_axiom_flags_from_type(CowlAxiomType type)
	bint cowl_axiom_flags_has_type(CowlAxiomFlags flags, CowlAxiomType type)
	bint cowl_axiom_flags_has_all_types(CowlAxiomFlags flags)
	bint cowl_axiom_flags_has_no_types(CowlAxiomFlags flags)
	cowl_axiom_flags_foreach_type(flags, type)
