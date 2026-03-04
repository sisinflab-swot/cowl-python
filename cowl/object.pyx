"""
Implement the CowlObject type defined in the respective pxd file
"""

from cowl.object cimport CowlObject, CowlAny, cowl_retain, cowl_release, cowl_get_type, cowl_init
from cowl.object cimport cowl_is_primitive, cowl_is_entity, cowl_is_axiom, cowl_is_cls_exp
from cowl.object cimport cowl_is_obj_prop_exp, cowl_is_data_prop_exp, cowl_is_individual
from cowl.object cimport cowl_is_data_range, cowl_get_iri
from cowl.object cimport cowl_get_annot, cowl_to_string, cowl_to_debug_string
from cowl.object cimport cowl_is_reserved, cowl_hash, cowl_equals

from cowl.string cimport CowlString, cowl_string_get_raw
from cowl.iri cimport CowlIRI, cowl_iri_get_ns, cowl_iri_get_rem
from cowl.ulib cimport ustring_to_pystr, pystr_to_ustring, UString, UStrBuf
from cowl.object cimport Object

cdef class Object:
    """Wrapper of CowlObject"""

    def __cinit__(self):
        """Allocate the wrapper"""
        cowl_init()
        self.c_obj = NULL

    def __init__(self):
        """
        Initialize the Object class
        """
        cowl_init()

    def __dealloc__(self):
        """Release the underlying C object """
        if self.c_obj != NULL:
            cowl_release(self.c_obj)
            return

    # Python dunders

    def __str__(self) -> str:
        """Return the string representation of the object"""
        cdef CowlString* str_rep = cowl_to_string(self.c_obj)
        cdef UString *str_rep_str = cowl_string_get_raw(str_rep)
        result = ustring_to_pystr(str_rep_str)
        return result

    def __repr__(self) -> str:
        """Return the debug string representation of the object"""
        cdef CowlString* debug_str = cowl_to_debug_string(self.c_obj)
        cdef UString *debug_str_str = cowl_string_get_raw(debug_str)
        result = ustring_to_pystr(debug_str_str)
        return result

    def __eq__(self, Object other) -> bool:
        """Check if two object are equal"""
        return cowl_equals(self.c_obj, other.c_obj)

    def __hash__(self) -> int:
        """Return the integer has of a cowl object"""
        return cowl_hash(self.c_obj)
    
    # The following methods simply wrap the C functions in the object 

    def get_type(self) -> int:
        return cowl_get_type(self.c_obj)

    def is_primitive(self) -> bool:
        return cowl_is_primitive(self.c_obj)

    def is_entity(self) -> bool:
        return cowl_is_entity(self.c_obj)

    def is_axiom(self) -> bool:
        return cowl_is_axiom(self.c_obj)

    def is_cls_exp(self) -> bool:
        return cowl_is_cls_exp(self.c_obj)

    def is_obj_prop_exp(self) -> bool:
        return cowl_is_obj_prop_exp(self.c_obj)

    def is_data_prop_exp(self) -> bool:
        return cowl_is_data_prop_exp(self.c_obj)

    def is_individual(self) -> bool:
        return cowl_is_individual(self.c_obj)

    def is_data_range(self) -> bool:
        return cowl_is_data_range(self.c_obj)

    def is_reserved(self) -> bool:
        return cowl_is_reserved(self.c_obj)
    
    # IRI is a little bit trickier, since not every object is IRI-identifiable
    # Also, i want the python string version of an IRI
    # So a little bit of conversion and error checking is needed

    def get_namespace(self) -> str:
        cdef CowlIRI* iri = cowl_get_iri(self.c_obj)
        if iri == NULL:
            raise ValueError("Cannot ask for namespace of a non-IRI object")
        cdef CowlString *ns = cowl_iri_get_ns(iri)
        cdef UString *ns_str = cowl_string_get_raw(ns)
        return ustring_to_pystr(ns_str)

    def get_remainder(self) -> str:
        cdef CowlIRI* iri = cowl_get_iri(self.c_obj) 
        if iri == NULL:
            raise ValueError("Cannot ask for reminder of a non-IRI object")
        cdef CowlString *rem  = cowl_iri_get_rem(iri)
        cdef UString *rem_str = cowl_string_get_raw(rem)        
        return ustring_to_pystr(rem_str)

    def get_iri(self) -> str:
        return f"{self.get_namespace()}#{self.get_remainder()}"
