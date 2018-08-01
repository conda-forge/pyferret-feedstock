#!/bin/bash

if [[ -n "$_CONDA_SET_FERRET" ]]; then
  unset FER_DIR
  unset FER_DSETS
  unset FER_DATA
  unset FER_DESCR
  unset FER_GRIDS
  unset FER_GO
  unset FER_PALETTE
  unset FER_FONTS
  unset PYFER_EXTERNAL_FUNCTIONS
  unset -f Faddpath
fi
