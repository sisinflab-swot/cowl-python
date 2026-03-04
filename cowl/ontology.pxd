"""Forwad declarations from cowl_ontology.h"""

from libc.stdint cimport uintptr_t

from cowl.object cimport Object 
from cowl.manager cimport CowlManager, CowlOntology, CowlOntologyId
from cowl.iri cimport CowlIRI
from cowl.vector cimport CowlVector
from cowl.ret cimport cowl_ret
from cowl.axiom_type cimport CowlAxiomType
from cowl.iterator cimport CowlIterator
from cowl.primitive_flags cimport CowlPrimitiveFlags
from cowl.axiom_flags cimport CowlAxiomFlags
from cowl.any cimport CowlAnyPrimitive, CowlAnyAxiom

cdef extern from "cowl_ontology.h":

    CowlManager *cowl_ontology_get_manager(CowlOntology *onto)
    #CowlSymTable *cowl_ontology_get_sym_table(CowlOntology *onto)
    CowlOntologyId cowl_ontology_get_id(CowlOntology *onto)
    void cowl_ontology_set_iri(CowlOntology *onto, CowlIRI *iri)
    void cowl_ontology_set_version(CowlOntology *onto, CowlIRI *version)
    
    CowlVector *cowl_ontology_get_annot(CowlOntology *onto)
    # cowl_ret cowl_ontology_add_annot(CowlOntology *onto, CowlAnnotation *annot)
    # void cowl_ontology_remove_annot(CowlOntology *onto, CowlAnnotation *annot)
    
    CowlOntology *cowl_ontology_get_import(CowlOntology *onto, CowlIRI *iri)
    CowlIRI *cowl_ontology_get_import_iri(CowlOntology *onto, CowlOntology *import_iri)
    cowl_ret cowl_ontology_add_import(CowlOntology *onto, CowlIRI *import_iri)
    void cowl_ontology_remove_import(CowlOntology *onto, CowlIRI *import_iri)
    
    cowl_ret cowl_ontology_add_axiom(CowlOntology *onto, CowlAnyAxiom *axiom)
    # void cowl_ontology_remove_axiom(CowlOntology *onto, CowlAnyAxiom *axiom)
    
    uintptr_t cowl_ontology_axiom_count(CowlOntology *onto, bint imports) 
    #uintptr_t cowl_ontology_imports_count(CowlOntology *onto, bint imports)
    uintptr_t cowl_ontology_axiom_count_for_type(CowlOntology *onto, CowlAxiomType ax_type, bint imports)
    uintptr_t cowl_ontology_axiom_count_for_types(CowlOntology *onto, CowlAxiomFlags types, bint imports)
    uintptr_t cowl_ontology_axiom_count_for_primitive(CowlOntology *onto, CowlAnyPrimitive *primitive, bint imports)
    uintptr_t cowl_ontology_primitives_count(CowlOntology *onto, CowlPrimitiveFlags flags, bint imports)
    
    bint cowl_ontology_has_primitive(CowlOntology *onto, CowlAnyPrimitive *primitive, bint imports)
    bint cowl_ontology_has_axiom(CowlOntology *onto, CowlAnyAxiom *axiom, bint imports)
    bint cowl_ontology_iterate_primitives(CowlOntology *onto, CowlPrimitiveFlags flags, CowlIterator *cowl_iter, bint imports)
    #bint cowl_ontology_iterate_imports(CowlOntology *onto, CowlIterator *cowl_iter, bint imports)
    bint cowl_ontology_iterate_import_iris(CowlOntology *onto, CowlIterator *cowl_iter, bint imports)
    bint cowl_ontology_iterate_axioms(CowlOntology *onto, CowlIterator *cowl_iter, bint imports)
    bint cowl_ontology_iterate_axioms_of_type(CowlOntology *onto, CowlAxiomType cowl_type, CowlIterator *cowl_iter, bint imports)
    bint cowl_ontology_iterate_axioms_of_types(CowlOntology *onto, CowlAxiomFlags types, CowlIterator *cowl_iter, bint imports)
    bint cowl_ontology_iterate_axioms_for_primitive(CowlOntology *onto, CowlAnyPrimitive *primitive, CowlIterator *cowl_iter, bint imports)
    #bint cowl_ontology_iterate_related(CowlOntology *onto, CowlAnyPrimitive *primitive, CowlAxiomType cowl_type, CowlPosition position, CowlIterator *iter, bint imports)

    # Inline functions
    #bint cowl_ontology_iterate_sub_classes(CowlOntology *onto, CowlClass *owl_class, CowlIterator *iter, bint imports)
    #bint cowl_ontology_iterate_super_classes(CowlOntology *onto, CowlClass *owl_class, CowlIterator *iter, bint imports)
    #bint cowl_ontology_iterate_eq_classes(CowlOntology *onto, CowlClass *owl_class, CowlIterator *iter, bint imports)
    #bint cowl_ontology_iterate_disjoint_classes(CowlOntology *onto, CowlClass *owl_class, CowlIterator *iter, bint imports)
    #bint cowl_ontology_iterate_types(CowlOntology *onto, CowlAnyIndividual *ind, CowlIterator *iter, bint imports)
  
