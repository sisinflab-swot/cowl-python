from cowl.primitive_type cimport CowlPrimitiveType

cdef class PrimitiveType:
    """Wrapper Python per CowlPrimitiveType"""

    CLASS = <int>CowlPrimitiveType.COWL_PT_CLASS
    OBJ_PROP = <int>CowlPrimitiveType.COWL_PT_OBJ_PROP
    DATA_PROP = <int>CowlPrimitiveType.COWL_PT_DATA_PROP
    ANNOT_PROP = <int>CowlPrimitiveType.COWL_PT_ANNOT_PROP
    NAMED_IND = <int>CowlPrimitiveType.COWL_PT_NAMED_IND
    ANON_IND = <int>CowlPrimitiveType.COWL_PT_ANON_IND
    DATATYPE = <int>CowlPrimitiveType.COWL_PT_DATATYPE
    IRI = <int>CowlPrimitiveType.COWL_PT_IRI
    COUNT = <int>CowlPrimitiveType.COWL_PT_COUNT
    FIRST = <int>CowlPrimitiveType.COWL_PT_FIRST

    _names = {
        CLASS: "CLASS",
        OBJ_PROP: "OBJ_PROP",
        DATA_PROP: "DATA_PROP",
        ANNOT_PROP: "ANNOT_PROP",
        NAMED_IND: "NAMED_IND",
        ANON_IND: "ANON_IND",
        DATATYPE: "DATATYPE",
        IRI: "IRI",
        COUNT: "COUNT",
        FIRST: "FIRST",
    }

    def to_str(value: int) -> str:
        """Restituisce il nome leggibile di un tipo primitivo"""
        return PrimitiveType._names.get(value, f"UNKNOWN({value})")
