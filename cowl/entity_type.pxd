cdef extern from "cowl_entity_type.h":

    ctypedef enum CowlEntityType:
        COWL_ET_CLASS
        COWL_ET_DATATYPE
        COWL_ET_OBJ_PROP
        COWL_ET_DATA_PROP
        COWL_ET_ANNOT_PROP
        COWL_ET_NAMED_IND
        COWL_ET_COUNT
        COWL_ET_FIRST