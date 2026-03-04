from cowl.cls_exp_type cimport CowlClsExpType

cdef class ClsExpType:
    CLASS = <int>CowlClsExpType.COWL_CET_CLASS
    OBJ_INTERSECT = <int>CowlClsExpType.COWL_CET_OBJ_INTERSECT
    OBJ_UNION = <int>CowlClsExpType.COWL_CET_OBJ_UNION
    OBJ_COMPL = <int>CowlClsExpType.COWL_CET_OBJ_COMPL
    OBJ_ONE_OF = <int>CowlClsExpType.COWL_CET_OBJ_ONE_OF
    OBJ_SOME = <int>CowlClsExpType.COWL_CET_OBJ_SOME
    OBJ_ALL = <int>CowlClsExpType.COWL_CET_OBJ_ALL
    OBJ_HAS_VALUE = <int>CowlClsExpType.COWL_CET_OBJ_HAS_VALUE
    OBJ_HAS_SELF = <int>CowlClsExpType.COWL_CET_OBJ_HAS_SELF
    OBJ_MIN_CARD = <int>CowlClsExpType.COWL_CET_OBJ_MIN_CARD
    OBJ_MAX_CARD = <int>CowlClsExpType.COWL_CET_OBJ_MAX_CARD
    OBJ_EXACT_CARD = <int>CowlClsExpType.COWL_CET_OBJ_EXACT_CARD
    DATA_SOME = <int>CowlClsExpType.COWL_CET_DATA_SOME
    DATA_ALL = <int>CowlClsExpType.COWL_CET_DATA_ALL
    DATA_HAS_VALUE = <int>CowlClsExpType.COWL_CET_DATA_HAS_VALUE
    DATA_MIN_CARD = <int>CowlClsExpType.COWL_CET_DATA_MIN_CARD
    DATA_MAX_CARD = <int>CowlClsExpType.COWL_CET_DATA_MAX_CARD
    DATA_EXACT_CARD = <int>CowlClsExpType.COWL_CET_DATA_EXACT_CARD
    COUNT = <int>CowlClsExpType.COWL_CET_COUNT
    FIRST = <int>CowlClsExpType.COWL_CET_FIRST

    _names = {
        CLASS: "CLASS",
        OBJ_INTERSECT: "OBJ_INTERSECT",
        OBJ_UNION: "OBJ_UNION",
        OBJ_COMPL: "OBJ_COMPL",
        OBJ_ONE_OF: "OBJ_ONE_OF",
        OBJ_SOME: "OBJ_SOME",
        OBJ_ALL: "OBJ_ALL",
        OBJ_HAS_VALUE: "OBJ_HAS_VALUE",
        OBJ_HAS_SELF: "OBJ_HAS_SELF",
        OBJ_MIN_CARD: "OBJ_MIN_CARD",
        OBJ_MAX_CARD: "OBJ_MAX_CARD",
        OBJ_EXACT_CARD: "OBJ_EXACT_CARD",
        DATA_SOME: "DATA_SOME",
        DATA_ALL: "DATA_ALL",
        DATA_HAS_VALUE: "DATA_HAS_VALUE",
        DATA_MIN_CARD: "DATA_MIN_CARD",
        DATA_MAX_CARD: "DATA_MAX_CARD",
        DATA_EXACT_CARD: "DATA_EXACT_CARD",
        COUNT: "COUNT",
        FIRST: "FIRST",
    }

    def to_str(value: int) -> str:
        """Restituisce il nome testuale del tipo di espressione di classe."""
        return ClsExpType._names.get(value, f"UNKNOWN({value})")
