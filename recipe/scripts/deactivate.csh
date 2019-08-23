#!/bin/csh

if ( $?_CONDA_SET_FERRET ) then
  unsetenv _CONDA_SET_FERRET
  unsetenv FER_DIR
  unsetenv FER_DSETS
  unsetenv FER_DATA
  unsetenv FER_DESCR
  unsetenv FER_GRIDS
  unsetenv FER_GO
  unsetenv FER_PALETTE
  unsetenv FER_FONTS
  unsetenv PYFER_EXTERNAL_FUNCTIONS
  unalias  Faddpath
endif
