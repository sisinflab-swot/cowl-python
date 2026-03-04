"""
Definition of manager and ontology classes and forward declaration of cowl manager methods
"""

from cowl.ulib cimport UString, UStrBuf
from cowl.ret cimport cowl_ret
from cowl.object cimport Object

cdef extern from "cowl.h":

    ctypedef struct CowlManager:
        pass

    ctypedef struct CowlOntology:
        pass

    ctypedef struct CowlOntologyId:
        pass

    CowlManager *cowl_manager()
    #void cowl_manager_set_reader(CowlManager *manager, CowlReader reader)
    #void cowl_manager_set_writer(CowlManager *manager, CowlWriter writer)
    #void cowl_manager_set_import_loader(CowlManager *manager, CowlImportLoader loader)
    #void cowl_manager_set_error_handler(CowlManager *manager, CowlErrorHandler handler)
    CowlOntology *cowl_manager_get_ontology(CowlManager *manager, CowlOntologyId *id)
    CowlOntology *cowl_manager_read_path(CowlManager *manager, UString path)
    #CowlOntology *cowl_manager_read_file(CowlManager *manager, FILE *file)
    CowlOntology *cowl_manager_read_string(CowlManager *manager, UString *string)
    #CowlOntology *cowl_manager_read_stream(CowlManager *manager, UIStream *stream)
    cowl_ret cowl_manager_write_path(CowlManager *manager, CowlOntology *ontology, UString path)
    #cowl_ret cowl_manager_write_file(CowlManager *manager, CowlOntology *ontology, FILE *file)
    cowl_ret cowl_manager_write_strbuf(CowlManager *manager, CowlOntology *ontology, UStrBuf *buf)
    #cowl_ret cowl_manager_write_stream(CowlManager *manager, CowlOntology *ontology, UOStream *stream)
    #CowlIStream *cowl_manager_get_istream(CowlManager *manager, CowlIStreamHandlers handlers)
    #CowlIStream *cowl_manager_get_istream_to_ontology(CowlManager *manager, CowlOntology *ontology)
    #CowlOStream *cowl_manager_get_ostream(CowlManager *manager, UOStream *stream)
    CowlOntology *cowl_manager_new_ontology(CowlManager *manager)

cdef class Ontology(Object):
    pass


cdef class Manager(Object):
    pass
