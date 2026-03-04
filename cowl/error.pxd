from cowl.ulib cimport UString

cdef extern from "cowl_error.h":
    ctypedef struct CowlError:
        pass
    
    ctypedef struct CowlSyntaxError:
        pass
    
    ctypedef struct CowlErrorLoc:
        pass
    
    UString cowl_error_to_ustring(CowlError* err)