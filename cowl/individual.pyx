from cowl.any cimport CowlAnyIndividual

cdef class Individual(Primitive):
    def is_named(self):
        return cowl_individual_is_named(<CowlAnyIndividual*>self.c_obj)