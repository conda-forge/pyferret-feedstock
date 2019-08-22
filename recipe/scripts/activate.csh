#!/bin/csh

setenv _CONDA_SET_FERRET 1

setenv FER_DIR "$CONDA_PREFIX"

## Dataset directory (not packaged yet).
setenv FER_DSETS "$CONDA_PREFIX/share/fer_dsets"

## Space-separated lists of directories examined when searching
## for (data, descriptor, grid, go-script) files without path components
setenv FER_DATA ". ${FER_DSETS}/data $CONDA_PREFIX/go $CONDA_PREFIX/examples"
setenv FER_DESCR ". ${FER_DSETS}/descr"
setenv FER_GRIDS ". ${FER_DSETS}/grids"
setenv FER_GO ". $CONDA_PREFIX/go $CONDA_PREFIX/examples $CONDA_PREFIX/contrib"

## Space-separated list of directories for Ferret color palettes and symbols
setenv FER_PALETTE ". $CONDA_PREFIX/ppl"

## Directory for Ferret fonts
setenv FER_FONTS "$CONDA_PREFIX/ppl/fonts"

## PyFerret external function files (shared-object libraries)
setenv PYFER_EXTERNAL_FUNCTIONS "$CONDA_PREFIX/ext_func/pylibs"

## Faddpath: a tool to quickly add paths to the search lists
alias Faddpath 'if ( "\!*" != "" ) then \
                   setenv FER_GO "$FER_GO \!*" \
                   setenv FER_DATA "$FER_DATA \!*" \
                   setenv FER_DESCR "$FER_DESCR \!*" \
                   setenv FER_GRIDS "$FER_GRIDS \!*" \
                else \
                   echo "    Usage: Faddpath new_directory_1 ... " \
                endif'

