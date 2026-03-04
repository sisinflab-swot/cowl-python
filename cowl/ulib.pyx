"""Implementation of ulib.pxd functions"""

cdef UString pystr_to_ustring(pystr):
    """Convert a python string to an UString"""
    cdef UString str = ustring_copy(pystr.encode('utf-8'), len(pystr))
    return str

cdef ustring_to_pystr(const UString *str):
    """Convert a ustring to a python string"""
    pystr = ustring_data(str[0]).decode('utf-8')[:ustring_length(str[0])]
    return pystr

