"""Forward delcaration"""

# from cowl.string cimport CowlString
# from cowl.ulib cimport UString

cdef extern from "cowl_ret.h":

    # Enumeration of cowl_ret
    ctypedef enum cowl_ret:
        COWL_OK
        COWL_ERR
        COWL_ERR_IO
        COWL_ERR_MEM
        COWL_ERR_SYNTAX
        COWL_ERR_IMPORT
        COWL_RET_COUNT
        COWL_RET_FIRST

    # Function declarations
    # cowl_ret cowl_ret_from_ustream(ustream_ret ret)
    # cowl_ret cowl_ret_from_uvec(uvec_ret ret)
    # cowl_ret cowl_ret_from_uhash(uhash_ret ret)
    # UString cowl_ret_to_ustring(cowl_ret ret)
    # CowlString* cowl_ret_to_string(cowl_ret ret)

