#!/bin/bash

if [ $(uname) == Linux ]; then
  export LIBZ_DIR=$PREFIX
  export READLINE_DIR=$PREFIX
  export HDF5_DIR=$PREFIX
  export NETCDF4_DIR=$PREFIX
  export FER_DIR=$PREFIX
  export FC="gfortran"
  export LD_X11="-L/usr/lib64 -lX11"

  # set in conda_forge_build_setup to `-j2 ${MAKEFLAGS}` and that breaks the build here.
  export MAKEFLAGS=""

  make
  # make run_tests  # Image mismatch issues.
  make install

  # Activate pyferret env vars.
  ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
  DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
  mkdir -p $ACTIVATE_DIR
  mkdir -p $DEACTIVATE_DIR

  cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pyferret-activate.sh
  cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pyferret-deactivate.sh
  cp $RECIPE_DIR/scripts/pyferret $PREFIX/bin/pyferret
  ln -s $PREFIX/bin/pyferret $PREFIX/bin/ferret
fi

if [ $(uname) == Darwin ]; then
  mkdir -p $PREFIX/bin
  cp -r $SRC_DIR/bin/* $PREFIX/bin/

  mkdir -p $PREFIX/contrib
  cp -r $SRC_DIR/contrib/* $PREFIX/contrib

  mkdir -p $PREFIX/examples
  cp -r $SRC_DIR/examples/* $PREFIX/examples

  mkdir -p $PREFIX/ext_func
  cp -r $SRC_DIR/ext_func/* $PREFIX/ext_func/

  mkdir -p $PREFIX/go
  cp -r $SRC_DIR/go/* $PREFIX/go

  mkdir -p $PREFIX/ppl
  cp -r $SRC_DIR/ppl/* $PREFIX/ppl/

  mkdir -p $SP_DIR
  cp -r $SRC_DIR/lib/python2.7/site-packages/* $SP_DIR/
fi
