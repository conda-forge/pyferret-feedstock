#!/bin/bash

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
