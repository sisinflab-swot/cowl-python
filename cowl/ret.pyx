from cowl.ret cimport (
    cowl_ret,
    COWL_OK, COWL_ERR, COWL_ERR_IO, COWL_ERR_MEM,
    COWL_ERR_SYNTAX, COWL_ERR_IMPORT,
    COWL_RET_COUNT, COWL_RET_FIRST,
    cowl_ret_to_ustring,
    cowl_ret_to_string
)
from cowl.string cimport String, cowl_string_get_raw
from cowl.ulib cimport ustring_to_pystr, ustring_deinit

# =============================================================================
# Classe wrapper
# =============================================================================

cdef class CowlRet:
    # Valore interno C
    cdef cowl_ret _value

    def __cinit__(self, int value=0):
        self._value = <cowl_ret>value

    OK = COWL_OK
    ERR = COWL_ERR
    ERR_IO = COWL_ERR_IO
    ERR_MEM = COWL_ERR_MEM
    ERR_SYNTAX = COWL_ERR_SYNTAX
    ERR_IMPORT = COWL_ERR_IMPORT
    RET_COUNT = COWL_RET_COUNT
    RET_FIRST = COWL_RET_FIRST


    def __str__(self) -> str:
        """Restituisce una rappresentazione testuale leggibile."""
        cdef CowlString * str_rep = cowl_ret_to_string(self._value)
        cdef UString *str_rep_str = cowl_string_get_raw(str_rep)
        result = ustring_to_pystr(str_rep_str)
        return result


    def __repr__(self) -> str:
        return f"<CowlRet {int(self._value)}: '{str(self)}'>"

    def __int__(self):
        """Restituisce il valore intero sottostante."""
        return <int>self._value

    def __eq__(self, other):
        if isinstance(other, CowlRet):
            return self._value == other._value
        elif isinstance(other, int):
            return <int>self._value == other
        return NotImplemented

    def __hash__(self):
        return hash(<int>self._value)

    cdef cowl_ret c_value(self):
        """Restituisce il valore C nativo (cowl_ret)."""
        return self._value

    def to_CowlString(self):
        """Restituisce un `CowlString*` (non gestito in Python)."""
        cdef String s = String.__new__(String)
        s.c_obj = cowl_ret_to_string(self._value)
        return s
