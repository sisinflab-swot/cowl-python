from cpython cimport PyErr_SetString, PyErr_SetObject
from cowl.error cimport CowlError, cowl_error_to_ustring
from cowl.ulib cimport UString, ustring_to_pystr, ustring_deinit
from cowl.object cimport cowl_release
from libc.stdint cimport uintptr_t

# Callback C: firma allineata al .pxd (nessun "const")
cdef void handle_error(void* ctx, const CowlError* err) noexcept nogil:
    cdef UString err_str  # dichiarazione prima di qualsiasi istruzione
    with gil:
        print("handle_error called!", <uintptr_t>ctx, <uintptr_t>err)
        err_str = cowl_error_to_ustring(err)
        if &err_str != NULL:
            try:
                PyErr_SetObject(Exception, ustring_to_pystr(&err_str))
            except Exception:
                PyErr_SetString(Exception, "CowlError (errore nel recupero della descrizione dell'errore)")
            finally:
                ustring_deinit(&err_str)
        else:
            PyErr_SetString(Exception, "CowlError (descrizione non disponibile)")

cdef class ErrorHandler:
    def __cinit__(self):
        self.eh.ctx = NULL
        self.eh.handle_error = handle_error
        self.eh.free = NULL
        self.handle_error_callback = None
        self.free_callback = None

    def __dealloc__(self):
        if self.eh.free != NULL and self.eh.ctx != NULL:
            self.eh.free(self.eh.ctx)
        self.eh.ctx = NULL
        self.eh.handle_error = NULL
        self.eh.free = NULL
        cowl_release(&self.eh)