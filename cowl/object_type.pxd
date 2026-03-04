"""Forward declarations"""
cdef extern from "cowl_object_type.h":

    cdef enum CowlObjectType:
        COWL_OT_STRING = 0                   # String
        COWL_OT_VECTOR                       # Vector
        COWL_OT_TABLE                        # Hash table
        COWL_OT_IRI                          # IRI
        COWL_OT_LITERAL                      # Literal
        COWL_OT_FACET_RESTR                  # Facet restriction
        COWL_OT_ONTOLOGY                     # Ontology
        COWL_OT_MANAGER                      # Ontology manager
        COWL_OT_SYM_TABLE                    # Symbol table
        COWL_OT_ISTREAM                      # Ontology input stream
        COWL_OT_OSTREAM                      # Ontology output stream
        COWL_OT_ANNOTATION                   # Annotation
        COWL_OT_ANNOT_PROP                   # Annotation property
        COWL_OT_A_DECL                       # Declaration
        COWL_OT_A_DATATYPE_DEF               # Datatype definition
        COWL_OT_A_SUB_CLASS                  # Subclass
        COWL_OT_A_EQUIV_CLASSES              # Equivalent classes
        COWL_OT_A_DISJ_CLASSES               # Disjoint classes
        COWL_OT_A_DISJ_UNION                 # Disjoint union
        COWL_OT_A_CLASS_ASSERT               # Class assertion
        COWL_OT_A_SAME_IND                   # Same individual
        COWL_OT_A_DIFF_IND                   # Different individuals
        COWL_OT_A_OBJ_PROP_ASSERT            # Object property assertion
        COWL_OT_A_NEG_OBJ_PROP_ASSERT        # Negative object property assertion
        COWL_OT_A_DATA_PROP_ASSERT           # Data property assertion
        COWL_OT_A_NEG_DATA_PROP_ASSERT       # Negative data property assertion
        COWL_OT_A_SUB_OBJ_PROP               # Object subproperty
        COWL_OT_A_INV_OBJ_PROP               # Inverse object properties
        COWL_OT_A_EQUIV_OBJ_PROP             # Equivalent object properties
        COWL_OT_A_DISJ_OBJ_PROP              # Disjoint object properties
        COWL_OT_A_FUNC_OBJ_PROP              # Functional object property
        COWL_OT_A_INV_FUNC_OBJ_PROP          # Inverse functional object property
        COWL_OT_A_SYMM_OBJ_PROP              # Symmetric object property
        COWL_OT_A_ASYMM_OBJ_PROP             # Asymmetric object property
        COWL_OT_A_TRANS_OBJ_PROP             # Transitive object property
        COWL_OT_A_REFL_OBJ_PROP              # Reflexive object property
        COWL_OT_A_IRREFL_OBJ_PROP            # Irreflexive object property
        COWL_OT_A_OBJ_PROP_DOMAIN            # Object property domain
        COWL_OT_A_OBJ_PROP_RANGE             # Object property range
        COWL_OT_A_SUB_DATA_PROP              # Data subproperty
        COWL_OT_A_EQUIV_DATA_PROP            # Equivalent data properties
        COWL_OT_A_DISJ_DATA_PROP             # Disjoint data properties
        COWL_OT_A_FUNC_DATA_PROP             # Functional data property
        COWL_OT_A_DATA_PROP_DOMAIN           # Data property domain
        COWL_OT_A_DATA_PROP_RANGE            # Data property range
        COWL_OT_A_HAS_KEY                    # Has key
        COWL_OT_A_ANNOT_ASSERT               # Annotation assertion
        COWL_OT_A_SUB_ANNOT_PROP             # Annotation subproperty
        COWL_OT_A_ANNOT_PROP_DOMAIN          # Annotation property domain
        COWL_OT_A_ANNOT_PROP_RANGE           # Annotation property range
        COWL_OT_CE_CLASS                     # Class
        COWL_OT_CE_OBJ_SOME                  # "some values from" object property restriction
        COWL_OT_CE_OBJ_ALL                   # "all values from" object property restriction
        COWL_OT_CE_OBJ_MIN_CARD              # "minimum cardinality" object property restriction
        COWL_OT_CE_OBJ_MAX_CARD              # "maximum cardinality" object property restriction
        COWL_OT_CE_OBJ_EXACT_CARD            # "exact cardinality" object property restriction
        COWL_OT_CE_OBJ_HAS_VALUE             # "has value" object property restriction
        COWL_OT_CE_OBJ_HAS_SELF              # "has self" object property restriction
        COWL_OT_CE_DATA_SOME                 # "some values from" data property restriction
        COWL_OT_CE_DATA_ALL                  # "all values from" data property restriction
        COWL_OT_CE_DATA_MIN_CARD             # "min cardinality" data property restriction
        COWL_OT_CE_DATA_MAX_CARD             # "max cardinality" data property restriction
        COWL_OT_CE_DATA_EXACT_CARD           # "exact cardinality" data property restriction
        COWL_OT_CE_DATA_HAS_VALUE            # "has value" data property restriction
        COWL_OT_CE_OBJ_INTERSECT             # Intersection of class expressions
        COWL_OT_CE_OBJ_UNION                 # Union of class expressions
        COWL_OT_CE_OBJ_COMPL                 # Complement of a class expression
        COWL_OT_CE_OBJ_ONE_OF                # Enumeration of individuals
        COWL_OT_DPE_DATA_PROP                # Data property
        COWL_OT_DR_DATATYPE                  # Datatype
        COWL_OT_DR_DATATYPE_RESTR            # Datatype restriction
        COWL_OT_DR_DATA_INTERSECT            # Intersection of data ranges
        COWL_OT_DR_DATA_UNION                # Union of data ranges
        COWL_OT_DR_DATA_COMPL                # Complement of data ranges
        COWL_OT_DR_DATA_ONE_OF               # Enumeration of literals
        COWL_OT_I_ANONYMOUS                  # Anonymous individual
        COWL_OT_I_NAMED                      # Named individual
        COWL_OT_OPE_OBJ_PROP                 # Object property
        COWL_OT_OPE_INV_OBJ_PROP             # Inverse object property
        COWL_OT_COUNT                        # Number of enum values
        COWL_OT_FIRST = 0                    # First enum value
        COWL_OT_FIRST_A = COWL_OT_A_DECL     # First axiom type
        COWL_OT_LAST_A = COWL_OT_A_ANNOT_PROP_RANGE   # Last axiom type
        COWL_OT_FIRST_CE = COWL_OT_CE_CLASS  # First class expression type
        COWL_OT_LAST_CE = COWL_OT_CE_OBJ_ONE_OF # Last class expression type
        COWL_OT_FIRST_OPE = COWL_OT_OPE_OBJ_PROP # First object property expression type
        COWL_OT_LAST_OPE = COWL_OT_OPE_INV_OBJ_PROP # Last object property expression type
        COWL_OT_FIRST_I = COWL_OT_I_ANONYMOUS # First individual type
        COWL_OT_LAST_I = COWL_OT_I_NAMED     # Last individual type
        COWL_OT_FIRST_DR = COWL_OT_DR_DATATYPE # First data range type
        COWL_OT_LAST_DR = COWL_OT_DR_DATA_ONE_OF # Last data range type

    # Function declarations
    #UString cowl_object_type_to_ustring(CowlObjectType type)
    #CowlString *cowl_object_type_to_string(CowlObjectType type)

