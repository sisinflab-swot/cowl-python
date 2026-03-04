import os
import sys
import ctypes

this_dir = os.path.dirname(__file__)

if sys.platform == "darwin":
    libcowl_filename = "libcowl.dylib"
    ulib_filename = "ulib.dylib"
    env_var = "DYLD_LIBRARY_PATH"
elif sys.platform == "win32":
    libcowl_filename = "libcowl.dll"
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
from .object import pycowl_init

pycowl_init()

