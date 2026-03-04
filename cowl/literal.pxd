from cowl.string cimport CowlString
from cowl.datatype cimport CowlDatatype
from cowl.annot_value cimport AnnotValue
from cowl.ulib cimport UString

cdef extern from "cowl_literal.h":
    ctypedef struct CowlLiteral

    CowlLiteral *cowl_literal(CowlDatatype *dt, CowlString *value, CowlString *lang)
    CowlLiteral *cowl_literal_from_string(UString dt, UString value, UString lang)
    CowlDatatype *cowl_literal_get_datatype(CowlLiteral *literal)

cdef class Literal(AnnotValue):
    pass