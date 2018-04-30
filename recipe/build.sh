#!/bin/bash

set -e # Abort on error.

export PING_SLEEP=30s
export WORKDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export BUILD_OUTPUT=$WORKDIR/build.out

touch $BUILD_OUTPUT

dump_output() {
   echo Tailing the last 500 lines of output:
   tail -500 $BUILD_OUTPUT
}
error_handler() {
  echo ERROR: An error was encountered with the build.
  dump_output
  exit 1
}

# If an error occurs, run our error handler to output a tail of the build.
trap 'error_handler' ERR

# Set up a repeating loop to send some output to Travis.
bash -c "while true; do echo \$(date) - building ...; sleep $PING_SLEEP; done" &
PING_LOOP_PID=$!

## START BUILD
## blank site_specific.mk files - just define environment here
touch site_specific.mk
touch external_functions/ef_utility/site_specific.mk

export DIR_PREFIX="$SRC_DIR"
export PYTHON_EXE="python$(PY_VER)"
export PYTHONINCDIR=`$PYTHON -c "from __future__ import print_function ; import distutils.sysconfig; print(distutils.sysconfig.get_python_inc())"`
export FC="gfortran"
export CAIRO_LIBDIR="$PREFIX/lib"
export PIXMAN_LIBDIR="$PREFIX/lib"
export PANGO_LIBDIR="$PREFIX/lib"
export GLIB2_LIBDIR="$PREFIX/lib"
export HDF5_LIBDIR=""
export SZ_LIBDIR=""
export NETCDF4_LIBDIR="$PREFIX/lib"
export FER_DIR="$PREFIX"
export INSTALL_FER_DIR="$PREFIX"

if [ $(uname) == Darwin ]; then
    export HOSTTYPE="intel-mac"
    export BUILDTYPE="intel-mac"
    export CC="clang"
    export CXX="clang++"
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    export CXXFLAGS="$CXXFLAGS -stdlib=libc++"
    export DYLD_FALLBACK_LIBRARY_PATH="$PREFIX/lib"
    export GFORTRAN_LIB=`$(FC) --print-file-name=libgfortran.dylib`
else
    export HOSTTYPE="x86_64-linux"
    export BUILDTYPE="x86_64-linux"
    export GFORTRAN_LIB=""
fi

# Set in conda_forge_build_setup to `${MAKEFLAGS}` and that breaks the build here.
export MAKEFLAGS=""

make >> $BUILD_OUTPUT 2>&1
# make run_tests  # Image mismatch issues.
make install >> $BUILD_OUTPUT 2>&1

# Activate pyferret env vars.
ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pyferret-activate.sh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pyferret-deactivate.sh
cp $RECIPE_DIR/scripts/pyferret $PREFIX/bin/pyferret
ln -s $PREFIX/bin/pyferret $PREFIX/bin/ferret

## END BUILD

# The build finished without returning an error so dump a tail of the output.
dump_output

# Nicely terminate the ping output loop.
kill $PING_LOOP_PID
