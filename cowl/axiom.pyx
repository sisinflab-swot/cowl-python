from cowl.object cimport Object, cowl_retain
from cowl.any cimport CowlAnyAxiom
from cowl.vector cimport Vector, cowl_vector_empty

_AXIOM_REGISTRY = {}

def register_axiom(axiom_type, cls):
    print(f"registrando assioma: {axiom_type}, {cls}")
    _AXIOM_REGISTRY[axiom_type] = cls

cdef class Axiom(Object):
    def get_type(self):
        if self.c_obj == NULL:
            raise ValueError("Axiom non inizializzato")
        return cowl_axiom_get_type(<CowlAnyAxiom*> self.c_obj)

    def whoami(self):
        print("Sono Axiom")

    def get_annot(self):
        if self.c_obj == NULL:
            print("[ERROR] Axiom non inizializzato: self.c_obj == NULL")
            raise ValueError("Axiom non inizializzato")

        cdef Vector vec = Vector.__new__(Vector)

        try:
            vec.v = cowl_axiom_get_annot(self.c_obj)
        except Exception as e:
            print(f"[ERROR] Exception during cowl_axiom_get_annot: {e}")
            raise

        if vec.v == NULL:
            vec.v = cowl_vector_empty()
        else:
            cowl_retain(vec.v)

        return vec

    
    
        
    
