"""
Forward some ulib functions to cython, in order to access C objects
and convert strings
"""

from libc.stdint cimport uintptr_t

cdef extern from "ulib.h":
    # See ulib documentation

    ctypedef struct UString:
        pass

    ctypedef struct UStrBuf:
        pass

    const char *ustring_data(UString str)
    uintptr_t ustring_length(UString str)
    UString ustring_copy(const char *buf, uintptr_t size)
    void ustring_deinit(UString *str)

    # UStrBuf
    UStrBuf ustrbuf()
    UString ustrbuf_to_ustring(UStrBuf *buf)

"""Methods for converting a string between python and UString"""
cdef UString pystr_to_ustring(pystr)
cdef ustring_to_pystr(const UString *str)

