from pathlib import Path

import subprocess
import os
import shutil
import glob
import sys

import setuptools
import setuptools.command.build_ext
from Cython.Utils import PACKAGE_FILES
from Cython.Build import cythonize

THIS_DIRECTORY = Path('.')
LONG_DESCRIPTION = (THIS_DIRECTORY / "README.md").read_text()
COWL_LIB_DIRECTORY = THIS_DIRECTORY / "lib"/ "cowl"
COWL_PACKAGE_DIRECTORY = THIS_DIRECTORY / "cowl"
BINARY_DIR = COWL_LIB_DIRECTORY / "build"
COMPILED_FLAG = THIS_DIRECTORY / "cowl.compiled"

# Cowl config
BUILD_TYPE='Debug'
COWL_LTO='OFF'
COWL_LIBRARY_TYPE='SHARED'
COWL_ENTITY_IDS='ON'

if sys.platform == "darwin":

    # Libraries to link
    COWL_OBJECTS = [
        os.path.join(BINARY_DIR, 'libcowl.dylib'),
        os.path.join(BINARY_DIR, 'lib', 'ulib', 'ulib.dylib')
    ]

    # Objects to copy inside the cowl/ module and include alongside the extensions
    EXTRA_OBJECTS = COWL_OBJECTS

    # Extra config/compile arguments platform specific
    PLATFORM_CONFIG_ARGS = []
    PLATFORM_COMPILE_ARGS = ['--parallel']

elif sys.platform == "win32":

    COWL_OBJECTS = [
        os.path.join(BINARY_DIR, BUILD_TYPE, 'cowl.lib'),
        os.path.join(BINARY_DIR, 'lib', 'ulib', BUILD_TYPE, 'ulib.lib')
    ]

    EXTRA_OBJECTS = [
        os.path.join(BINARY_DIR, BUILD_TYPE, 'cowl.dll'),
        os.path.join(BINARY_DIR, 'lib', 'ulib', BUILD_TYPE, 'ulib.dll')
    ]

    PLATFORM_CONFIG_ARGS = ['-A', 'x64']
    PLATFORM_COMPILE_ARGS = ['--config', BUILD_TYPE]

else:

    COWL_OBJECTS =[
        os.path.join(BINARY_DIR, 'libcowl.so'),
        os.path.join(BINARY_DIR, 'lib', 'ulib', 'ulib.so')
    ]

    EXTRA_OBJECTS = COWL_OBJECTS
    PLATFORM_CONFIG_ARGS = []
    PLATFORM_COMPILE_ARGS = ['--parallel']


def config_cowl():
    config_cmd = [
            'cmake', *PLATFORM_CONFIG_ARGS,
            '-B', str(BINARY_DIR),
            f'-DCMAKE_BUILD_TYPE={BUILD_TYPE}',
            f'-DCOWL_LTO={COWL_LTO}',
            f'-DCOWL_LIBRARY_TYPE={COWL_LIBRARY_TYPE}',
            f'-DCOWL_ENTITY_IDS={COWL_ENTITY_IDS}',
            f'-DULIB_LIBRARY_TYPE={COWL_LIBRARY_TYPE}',
            f'-DULIB_LTO={COWL_LTO}',
            f'{COWL_LIB_DIRECTORY}'
    ]

    try:
        subprocess.run(config_cmd, check=True)
    except subprocess.CalledProcessError as e:
        clean_cowl()
        raise e


def compile_cowl():
    compile_cmd = [
            'cmake',
            '--build', str(BINARY_DIR),
            *PLATFORM_COMPILE_ARGS,
            '--target', 'cowl',
    ]

    try:
        subprocess.run(compile_cmd, check=True)
    except subprocess.CalledProcessError as e:
        clean_cowl()
        raise e


def clean_cowl():
    try:
        shutil.rmtree(BINARY_DIR)
        shutil.rmtree(COMPILED_FLAG)
    except FileNotFoundError:
        pass


def ensure_cowl():
    if not is_cowl_available():
        clean_cowl()
        config_cowl()
        compile_cowl()
        with open(COMPILED_FLAG, 'w') as f:
            f.write("okay")


def is_cowl_available():
    return COMPILED_FLAG.exists()


def cowl_include_dir():
    ensure_cowl()
    return [
            str(COWL_LIB_DIRECTORY / 'include'),
            str(COWL_LIB_DIRECTORY / 'lib' / 'ulib' / 'include')
    ]


def cowl_objects():
    ensure_cowl()
    ret = []

    for file in COWL_OBJECTS:
        filename = Path(file).name
        shutil.copy(file, os.path.join(COWL_PACKAGE_DIRECTORY, filename))
        ret.append(os.path.join(COWL_PACKAGE_DIRECTORY, filename))

    return ret


def cowl_macros():
    return [
        ("COWL_BUILDING", "1"),
        ("COWL_DEFAULT_READER", "functional"),
        ("COWL_DEFAULT_WRITER", "functional"),
        ("COWL_ENTITY_IDS", "1"),
        ("COWL_READER_FUNCTIONAL", "1"),
        ("COWL_VERSION_MAJOR", "0"),
        ("COWL_VERSION_MINOR", "7"),
        ("COWL_VERSION_PATCH", "0"),
        ("COWL_WRITER_FUNCTIONAL", "1")
    ]

def cowl_extensions():
    for source in glob.glob(str(COWL_PACKAGE_DIRECTORY / "*.pyx")):
        name = str(Path(source).stem)
        print("Building extension", name)
        yield setuptools.Extension(
            name=f'cowl.{name}',
            sources=[source],
            define_macros=cowl_macros(), # type: ignore
            include_dirs=cowl_include_dir(),
            library_dirs=[str(COWL_PACKAGE_DIRECTORY)],
            extra_objects = cowl_objects(),
            language='c'
        )


def get_extra_objects():
    ensure_cowl()
    dest_dir = os.path.join(THIS_DIRECTORY, 'cowl')
    filenames = []

    for obj_path in EXTRA_OBJECTS:
        if os.path.exists(obj_path):
            filename = os.path.basename(obj_path)
            dest_path = os.path.join(dest_dir, filename)
            shutil.copy2(obj_path, dest_path)
            filenames.append(filename)
        else:
            raise FileNotFoundError(f"File not found: {obj_path}")

    for file in os.listdir(dest_dir):
        if file.endswith('.pxd'):
            filenames.append(file)

    return filenames

setuptools.setup(
    name="cowl",
    version='0.0.1',
    author="Davide Loconte",
    author_email="davide.loconte@poliba.it",
    long_description=LONG_DESCRIPTION,
    long_description_content_type='text/markdown',
    package_data = {
        'cowl': get_extra_objects(),
    },
    packages = ['cowl'],
    package_dir={'cowl': 'cowl'},
    ext_modules=cythonize(list(cowl_extensions()), compiler_directives={'language_level': 3}),
    include_package_data=True
)
