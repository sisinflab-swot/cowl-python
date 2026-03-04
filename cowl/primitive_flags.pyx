from cowl.primitive_type cimport CowlPrimitiveType
from cowl.primitive_flags cimport (
    CowlPrimitiveFlags,
    COWL_PF_NONE,
    COWL_PF_ALL,
    COWL_PF_CLASS,
    COWL_PF_OBJ_PROP,
    COWL_PF_DATA_PROP,
    COWL_PF_ANNOT_PROP,
    COWL_PF_NAMED_IND,
    COWL_PF_ANON_IND,
    COWL_PF_DATATYPE,
    COWL_PF_IRI,
    COWL_PF_ENTITY,
)


cdef class PrimitiveFlags:
    """Wrapper Python per le costanti e funzioni CowlPrimitiveFlags"""

    NONE = COWL_PF_NONE
    ALL = COWL_PF_ALL
    CLASS = COWL_PF_CLASS
    OBJ_PROP = COWL_PF_OBJ_PROP
    DATA_PROP = COWL_PF_DATA_PROP
    ANNOT_PROP = COWL_PF_ANNOT_PROP
    NAMED_IND = COWL_PF_NAMED_IND
    ANON_IND = COWL_PF_ANON_IND
    DATATYPE = COWL_PF_DATATYPE
    IRI = COWL_PF_IRI
    ENTITY = COWL_PF_ENTITY

    _names = {
        NONE: "NONE",
        ALL: "ALL",
        CLASS: "CLASS",
        OBJ_PROP: "OBJ_PROP",
        DATA_PROP: "DATA_PROP",
        ANNOT_PROP: "ANNOT_PROP",
        NAMED_IND: "NAMED_IND",
        ANON_IND: "ANON_IND",
        DATATYPE: "DATATYPE",
        IRI: "IRI",
        ENTITY: "ENTITY",
    }

    def to_str(value: int) -> str:
        """Restituisce il nome leggibile di un flag singolo"""
        return PrimitiveFlags._names.get(value, f"UNKNOWN({value})")

    def flags_to_list(value: int) -> list:
        """Se value è una combinazione di flag, restituisce i nomi corrispondenti"""
        names = []
        for k, v in PrimitiveFlags._names.items():
            if value & k:
                names.append(v)
        return names