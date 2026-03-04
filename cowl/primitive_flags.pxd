"""Forward declarations"""

from cowl.primitive_type cimport CowlPrimitiveType

cdef extern from "cowl_primitive_flags.h":
    
    ctypedef unsigned char CowlPrimitiveFlags

    CowlPrimitiveFlags COWL_PF_NONE
    CowlPrimitiveFlags COWL_PF_ALL
    CowlPrimitiveFlags COWL_PF_CLASS
    CowlPrimitiveFlags COWL_PF_OBJ_PROP
    CowlPrimitiveFlags COWL_PF_DATA_PROP
    CowlPrimitiveFlags COWL_PF_ANNOT_PROP
    CowlPrimitiveFlags COWL_PF_NAMED_IND
    CowlPrimitiveFlags COWL_PF_ANON_IND
    CowlPrimitiveFlags COWL_PF_DATATYPE
    CowlPrimitiveFlags COWL_PF_IRI
    CowlPrimitiveFlags COWL_PF_ENTITY

    CowlPrimitiveFlags cowl_primitive_flags_from_type(CowlPrimitiveType type)
    bint cowl_primitive_flags_has_type(CowlPrimitiveFlags flags, CowlPrimitiveType type)

