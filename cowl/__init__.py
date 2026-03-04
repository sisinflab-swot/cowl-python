import os
import sys
import ctypes

this_dir = os.path.dirname(__file__)

if sys.platform == "darwin":
    libcowl_filename = "cowl.dylib"
    ulib_filename = "ulib.dylib"
    env_var = "DYLD_LIBRARY_PATH"
elif sys.platform == "win32":
    libcowl_filename = "cowl.dll"
    ulib_filename = "ulib.dll"
    env_var = "PATH"
else:
    libcowl_filename = "libcowl.so"
    ulib_filename = "ulib.so"
    env_var = "LD_LIBRARY_PATH"

libcowl_path = os.path.join(this_dir, libcowl_filename)
ulib_path = os.path.join(this_dir, ulib_filename)

ctypes.CDLL(ulib_path)
ctypes.CDLL(libcowl_path)

lib_dir = os.path.dirname(libcowl_path)
current_paths = os.environ.get(env_var, "")

if lib_dir not in current_paths:
    os.environ[env_var] = os.pathsep.join([lib_dir, current_paths])

from .manager import Manager, Ontology
from .primitive_flags import PrimitiveFlags
from .primitive_type import PrimitiveType
from .axiom_flags import AxiomFlags
from .axiom_type import AxiomType
from .axiom import Axiom, register_axiom
from .object import pycowl_init, Object
from .primitive import Primitive
from .vector import Vector
from .data_prop_assert_axiom import DataPropAssertAxiom
from .cls_assert_axiom import ClsAssertAxiom
from .sub_cls_axiom import SubClsAxiom
from .obj_prop_assert_axiom import ObjPropAssertAxiom

pycowl_init()
register_axiom(AxiomType.DATA_PROP_ASSERT, DataPropAssertAxiom)
register_axiom(AxiomType.CLASS_ASSERT, ClsAssertAxiom)
register_axiom(AxiomType.SUB_CLASS, SubClsAxiom)
register_axiom(AxiomType.OBJ_PROP_ASSERT, ObjPropAssertAxiom)
