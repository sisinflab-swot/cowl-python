
cdef extern from "cowl_annot_value_type.h":
    ctypedef enum CowlAnnotValueType:
        COWL_AVT_IRI
        COWL_AVT_LITERAL
        COWL_AVT_ANON_IND
        COWL_AVT_COUNT
        COWL_AVT_FIRST