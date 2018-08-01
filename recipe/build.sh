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

if [ $(uname) == Darwin ]; then
    export CC="clang"
    export CXX="clang++"
    export FC="gfortran"
    export MACOSX_DEPLOYMENT_TARGET="10.9"
    export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
    export CXXFLAGS="$CXXFLAGS -stdlib=libc++"
    export DYLD_FALLBACK_LIBRARY_PATH="$PREFIX/lib"
    export HOSTTYPE="intel-mac"
    export FER_DIR="$PREFIX"
    export BUILDTYPE="intel-mac"
    export GFORTRAN_LIB=`$FC --print-file-name=libgfortran.dylib`
else
    export FC="gfortran"
    export HOSTTYPE="x86_64-linux"
    export FER_DIR="$PREFIX"
    export BUILDTYPE="x86_64-linux"
    export GFORTRAN_LIB=""
fi

export PYTHONINCDIR=`$PYTHON -c "from __future__ import print_function ; import distutils.sysconfig; print(distutils.sysconfig.get_python_inc())"`

rm -f site_specific.mk
echo "DIR_PREFIX = $SRC_DIR" > site_specific.mk
echo "INSTALL_FER_DIR = $PREFIX" >> site_specific.mk
echo "BUILDTYPE = $BUILDTYPE" >> site_specific.mk
echo "PYTHON_EXE = python$PY_VER" >> site_specific.mk
echo "PYTHONINCDIR = $PYTHONINCDIR" >> site_specific.mk
echo "GFORTRAN_LIB = $GFORTRAN_LIB" >> site_specific.mk
echo "CAIRO_LIBDIR = $PREFIX/lib" >> site_specific.mk
echo "PIXMAN_LIBDIR = $PREFIX/lib" >> site_specific.mk
echo "PANGO_LIBDIR = $PREFIX/lib" >> site_specific.mk
echo "GLIB2_LIBDIR = $PREFIX/lib" >> site_specific.mk
echo "NETCDF_LIBDIR = $PREFIX/lib" >> site_specific.mk

rm -f external_functions/ef_utility/site_specific.mk
echo "BUILDTYPE = $BUILDTYPE" > external_functions/ef_utility/site_specific.mk
echo "PYTHON_EXE = python$PY_VER" >> external_functions/ef_utility/site_specific.mk
## single quotes on these two so it wil be exactly as shown
echo 'INSTALL_FER_DIR = $(FER_DIR)' >> external_functions/ef_utility/site_specific.mk
echo 'FER_LOCAL_EXTFCNS = $(INSTALL_FER_DIR)/ext_func/pylibs' >> external_functions/ef_utility/site_specific.mk

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
