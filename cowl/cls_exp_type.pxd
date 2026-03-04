cdef extern from "cowl_cls_exp_type.h":

    ctypedef enum CowlClsExpType:
        COWL_CET_CLASS
        COWL_CET_OBJ_INTERSECT
        COWL_CET_OBJ_UNION
        COWL_CET_OBJ_COMPL
        COWL_CET_OBJ_ONE_OF
        COWL_CET_OBJ_SOME
        COWL_CET_OBJ_ALL
        COWL_CET_OBJ_HAS_VALUE
        COWL_CET_OBJ_HAS_SELF
        COWL_CET_OBJ_MIN_CARD
        COWL_CET_OBJ_MAX_CARD
        COWL_CET_OBJ_EXACT_CARD
        COWL_CET_DATA_SOME
        COWL_CET_DATA_ALL
        COWL_CET_DATA_HAS_VALUE
        COWL_CET_DATA_MIN_CARD
        COWL_CET_DATA_MAX_CARD
        COWL_CET_DATA_EXACT_CARD
        COWL_CET_COUNT
        COWL_CET_FIRST
