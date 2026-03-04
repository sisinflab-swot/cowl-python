from cowl.error cimport CowlError

cdef extern from "cowl_error_handler.h":
    ctypedef struct CowlErrorHandler:
        void* ctx
        void (*handle_error)(void* ctx, CowlError* err)
        void (*free)(void* ctx)

cdef class ErrorHandler:
    cdef CowlErrorHandler eh
    cdef object handle_error_callback
    cdef object free_callback