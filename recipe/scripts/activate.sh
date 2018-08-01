#!/bin/bash

export _CONDA_SET_FERRET=1

## Dataset directory (not packaged yet).
export FER_DSETS="$CONDA_PREFIX/share/fer_dsets"

## Space-separated lists of directories examined when searching
## for (data, descriptor, grid, go-script) files without path components
export FER_DATA=". ${FER_DSETS}/data $CONDA_PREFIX/go $CONDA_PREFIX/examples"
export FER_DESCR=". ${FER_DSETS}/descr"
export FER_GRIDS=". ${FER_DSETS}/grids"
export FER_GO=". $CONDA_PREFIX/go $CONDA_PREFIX/examples $CONDA_PREFIX/contrib"

## Space-separated list of directories for Ferret color palettes and symbols
export FER_PALETTE=". $CONDA_PREFIX/ppl"

## Directory for Ferret fonts
export FER_FONTS="$CONDA_PREFIX/ppl/fonts"

## PyFerret external function files (shared-object libraries)
export PYFER_EXTERNAL_FUNCTIONS="$CONDA_PREFIX/ext_func/pylibs"

## Faddpath: a tool to quickly add paths to the search lists
Faddpath() { if [ -n "$*" ]
             then
                 export FER_GO="$FER_GO $*"
                 export FER_DATA="$FER_DATA $*"
                 export FER_DESCR="$FER_DESCR $*"
                 export FER_GRIDS="$FER_GRIDS $*"
             else
                 echo "    Usage: Faddpath new_directory_1 ..."
             fi }

