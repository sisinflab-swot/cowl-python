"""Forward delcaration"""

# cowl/string.pxd

from cowl.ulib cimport UString
from cowl.ret cimport cowl_ret

from libc.stdint cimport uintptr_t

cdef extern from "cowl_string.h":

    # Forward declare the CowlString struct
    ctypedef struct CowlString

    # Function declarations
    # CowlString* cowl_string(UString string)
    # CowlString* cowl_string_empty()
    # CowlString* cowl_string_intern(CowlString* string)
    # char const* cowl_string_get_cstring(CowlString* string)
    # uintptr_t cowl_string_get_length(CowlString* string)
    UString *cowl_string_get_raw(CowlString* string)

    # Strings that were not forwarded to the user
    #CowlString* cowl_string_with_format(char const* format, ...)
    #CowlString* cowl_string_concat(CowlString* lhs, CowlString* rhs)
    #cowl_ret cowl_string_to_int(CowlString* string, ulib_int* out, unsigned base)
    #cowl_ret cowl_string_to_uint(CowlString* string, ulib_uint* out, unsigned base)
    #cowl_ret cowl_string_to_float(CowlString* string, ulib_float* out)
    #CowlString* cowl_string_opt(UString string, int opts)
    #char* cowl_string_release_copying_cstring(CowlString* string)
