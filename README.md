# cowl-python

Python bindings for cowl-python.
Note that in the current version, its only purposes is to parse a CowlOntology
in order to be fed into `tiny-me-python`. No other functionality is currently
exposed.

## Requirements

`cowl-python` requires Python 3 and pip for installation.
During setup, `cowl` will be and compiled for the current platform, which
requires the following tools:

- cmake
- flex
- bison
- a C compiler (MSVC, gcc, or clang)

## Installation

You can install the library via pip:
```
$: pip install git+https://github.com/sisinflab-swot/cowl-python.git
```

Alternatively, if you have cloned the repository, navigate to the project directory and run:
```
$ pip install .
```

