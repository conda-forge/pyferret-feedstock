#!/bin/bash

export _CONDA_SET_FERRET=1

## Dataset directory (not packaged yet).
export FER_DSETS="$CONDA_PREFIX/fer_dsets"


## Space-separated list of default sites for ThreddsBrowser
## (SET /DATA /BROWSE or its alias OPEN)
## Assigned in this unusual way to make it easy to add/delete/rearrange sites.
export FER_DATA_THREDDS=""
export FER_DATA_THREDDS="${FER_DATA_THREDDS} http://ferret.pmel.noaa.gov/geoide/geoIDECleanCatalog.xml"
export FER_DATA_THREDDS="${FER_DATA_THREDDS} ${FER_DSETS}"

## Space-separated lists of directories examined when searching
## for (data, descriptor, grid, go-script) files without path components
export FER_DATA=". ${FER_DSETS}/data $CONDA_PREFIX/go $CONDA_PREFIX/examples"
export FER_DESCR=". ${FER_DSETS}/descr"
export FER_GRIDS=". ${FER_DSETS}/grids"
export FER_GO=". $CONDA_PREFIX/go $CONDA_PREFIX/examples $CONDA_PREFIX/contrib"

## Space-separated list of directories containing traditional
## Ferret external function files (shared-object libraries)
# export FER_EXTERNAL_FUNCTIONS="$CONDA_PREFIX/ext_func/libs"
## PyFerret external function files (shared-object libraries)
export PYFER_EXTERNAL_FUNCTIONS="$CONDA_PREFIX/ext_func/pylibs"

## Space-separated list of directories for Ferret color palettes
export FER_PALETTE=". $CONDA_PREFIX/ppl"

## Ferret's color palettes directory (old)
export SPECTRA="$CONDA_PREFIX/ppl"

## Directory for Ferret fonts
export FER_FONTS="$CONDA_PREFIX/ppl/fonts"
## Directory for Ferret fonts (old)
export PLOTFONTS="$CONDA_PREFIX/ppl/fonts"

## Directory containing threddsBrowser.jar and toolsUI.jar for ThreddsBrowser
## as well as the python2.x/site-packages directory for PyFerret Python packages
export FER_LIBS="$CONDA_PREFIX/lib"

## Ferret directory (old)
export FER_DAT="$CONDA_PREFIX"
