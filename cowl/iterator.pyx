from cowl.any cimport CowlAny, CowlAnyAxiom
from cpython.ref cimport Py_INCREF, Py_DECREF
from cowl.object cimport Object, cowl_is_axiom, cowl_is_primitive, cowl_retain, cowl_release
from cowl.axiom cimport Axiom, cowl_axiom_get_type
from cowl.primitive cimport Primitive
from cowl.axiom import _AXIOM_REGISTRY

cdef extern from "stdbool.h":
    ctypedef bint cbool_t "bool"

cdef cbool_t _py_callback_with_gil(void* ctx, CowlAny* obj) noexcept with gil:
    """Helper interno che gestisce le operazioni Python con GIL."""
    cdef object func = <object>ctx
    cdef object result
    cdef bint cont = 0

    try:
        if cowl_is_axiom(obj):
            t = cowl_axiom_get_type(<CowlAnyAxiom *> obj)
            py_type = _AXIOM_REGISTRY.get(<int> t, Axiom)
            ax = py_type.__new__(py_type)
            (<Axiom> ax).c_obj = obj
            cowl_retain(obj) # Retain the object to ensure it persists beyond the current scope
            result = func(ax)
        elif cowl_is_primitive(obj):
            px = Primitive.__new__(Primitive)
            (<Primitive>px).c_obj = obj
            cowl_retain(obj) # Retain the object to ensure it persists beyond the current scope
            result = func(px)
        else:
            o = Object.__new__(Object)
            (<Object>o).c_obj = obj
            cowl_retain(obj) # Retain the object to ensure it persists beyond the current scope
            result = func(o)
        cont = bool(result)
    except Exception as e:
        import traceback, sys
        traceback.print_exc(file=sys.stderr)
        cont = 0
    return cont

#cdef cbool_t _py_callback_wrapper(void* ctx, CowlAny* obj) noexcept nogil:
    #"""Wrapper C-compatibile che gestisce il GIL."""
    #return _py_callback_with_gil(ctx, obj)

cdef class Iterator:
    def __cinit__(self):
        self.it.ctx = NULL
        self.it.for_each = NULL
        self.pylist = None
        self.callback = None

    def __init__(self, object pylist, object callback=None):
        self.pylist = pylist
        if pylist is not None:
            Py_INCREF(pylist)

        self.it.ctx = <void*>pylist if callback is None else NULL
        self.it.for_each = NULL

        if callback is not None:
            self.callback = callback
            Py_INCREF(callback)
            self.it.ctx = <void*>callback
            self.it.for_each = _py_callback_with_gil

    def __dealloc__(self):
        if self.pylist is not None:
            Py_DECREF(self.pylist)
            self.pylist = None
        if self.callback is not None:
            Py_DECREF(self.callback)
            self.callback = None
        #self.it.ctx = NULL
        #self.it.for_each = NULL
        if &self.it != NULL:
            cowl_release(&self.it)

    cdef CowlIterator* get_cowl_iterator(self):
        return &self.it