from cowl.annot_value_type cimport CowlAnnotValueType

cdef class AnnotValueType:
    """Wrapper Python per CowlAnnotValueType"""

    IRI = <int>CowlAnnotValueType.COWL_AVT_IRI
    LITERAL = <int>CowlAnnotValueType.COWL_AVT_LITERAL
    ANON_IND = <int>CowlAnnotValueType.COWL_AVT_ANON_IND
    COUNT = <int>CowlAnnotValueType.COWL_AVT_COUNT
    FIRST = <int>CowlAnnotValueType.COWL_AVT_FIRST

    _names = {
        IRI: "IRI",
        LITERAL: "LITERAL",
        ANON_IND: "ANON_IND",
        COUNT: "COUNT",
        FIRST: "FIRST",
    }

    def __init__(self, value: int):
        self.value = value

    def __str__(self):
        """Restituisce il nome leggibile del valore"""
        return AnnotValueType._names.get(self.value, f"UNKNOWN({self.value})")

    def __repr__(self):
        """Rappresentazione utile in debug"""
        return f"<AnnotValueType {self.__str__()}>"

    def __int__(self):
        """Permette il cast diretto a int"""
        return self.value

    def __eq__(self, other):
        if isinstance(other, AnnotValueType):
            return self.value == other.value
        elif isinstance(other, int):
            return self.value == other
        return NotImplemented
