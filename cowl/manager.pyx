"""Implementation of manager and ontology objects"""

from cowl.object cimport Object
from cowl.manager cimport CowlManager, CowlOntology, CowlOntologyId, Ontology, Manager
from cowl.any cimport CowlAny
from cowl.manager cimport cowl_manager
from cowl.ulib cimport UString, UStrBuf, pystr_to_ustring, ustring_to_pystr, ustrbuf_to_ustring, ustrbuf, ustring_deinit

cdef class Manager(Object):
    """
    Implementation of Manager wrapper for CowlManager. For now, this class includes the ability
    of read ontologies from strings and paths.
    """
    def __init__(self):
        super().__init__()
        self.c_obj = cowl_manager()

    def read_path(self, path: str):
        cdef UString path_str = pystr_to_ustring(path)
        cdef CowlAny *ontology_ptr = <CowlAny *> cowl_manager_read_path(<CowlManager *> self.c_obj, path_str)

        if ontology_ptr == NULL:
            ustring_deinit(&path_str)
            raise ValueError("Failed to read ontology from path")

        ontology: Ontology = Ontology.__new__(Ontology)
        ontology.c_obj = ontology_ptr
        ustring_deinit(&path_str)
        return ontology

    def read_string(self, string: str):
        cdef UString string_str = pystr_to_ustring(string)
        cdef CowlAny *ontology_ptr = <CowlAny *> cowl_manager_read_string(<CowlManager *> self.c_obj, &string_str)

        if ontology_ptr == NULL:
            ustring_deinit(&string_str)
            raise ValueError("Failed to read ontology from string")

        ontology: Ontology = Ontology.__new__(Ontology)
        ontology.c_obj = ontology_ptr
        ustring_deinit(&string_str)
        return ontology

    def write_path(self, Ontology ontology, path: str):
        cdef UString string_str = pystr_to_ustring(path)
        cowl_manager_write_path(<CowlManager *> self.c_obj, <CowlOntology *> ontology.c_obj, string_str)
        ustring_deinit(&string_str)

    def write_str(self, Ontology ontology) -> str:
        cdef UStrBuf buffer = ustrbuf()
        cowl_manager_write_strbuf(<CowlManager *> self.c_obj, <CowlOntology *> ontology.c_obj, &buffer)
        cdef UString string = ustrbuf_to_ustring(&buffer)
        ret = ustring_to_pystr(&string)
        ustring_deinit(&string)
        return ret


cdef class Ontology(Object):
    """Wrapper of ontology object. This is a stub now. The interface will need to be extended"""
    def __init__(self):
        raise ValueError("You cannot instantiate an ontology directly. Use Manager methods instead")

