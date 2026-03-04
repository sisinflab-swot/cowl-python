"""Forward declarations from cowl_primitive_type.h"""

cdef extern from "cowl_primitive_type.h":

    cdef enum CowlPrimitiveType:
        COWL_PT_CLASS             # class
        COWL_PT_OBJ_PROP          # object property
        COWL_PT_DATA_PROP         # data property
        COWL_PT_ANNOT_PROP        # annotation property
        COWL_PT_NAMED_IND         # named individual
        COWL_PT_ANON_IND          # anonymous individual
        COWL_PT_DATATYPE          # datatype
        COWL_PT_IRI               # IRI
        COWL_PT_COUNT             # Number of enum values
        COWL_PT_FIRST = 0         # First enum value

