#!/bin/env bash

set -x 

if [ $(uname) == Darwin ]; then
    export HOSTTYPE="intel-mac"
    export FER_DIR="$PREFIX"
    export BUILDTYPE="$HOSTTYPE"
    export GFORTRAN_LIB=`$FC --print-file-name=libgfortran.dylib`
elif [[ $(uname) == Linux ]]; then
    export HOSTTYPE="x86_64-linux"
    export FER_DIR="$PREFIX"
    export BUILDTYPE="$HOSTTYPE"
    export GFORTRAN_LIB=""
    export CFLAGS="$CFLAGS -Wno-strict-aliasing"
    export CXXFLAGS="$CXXFLAGS -Wno-strict-aliasing"
    # try adding harfbuzz path explicity?
    export PATH="$CONDA_PREFIX/include/harfbuzz:$PATH"
    ls $CONDA_PREFIX/include/harfbuzz
    # see below
    export PANGO_INCLUDE = -I$CONDA_PREFIX/include/harfbuzz
fi

# # Pango uses harfbuzz whose include files may reside in their own "harfbuzz" subdirectory 
# # but the source files do not include this subdirectory in the includes statements
# ifeq ($(strip $(PANGO_LIBDIR)),)
# ifeq ($(shell /bin/ls -d /usr/include/harfbuzz 2>/dev/null),/usr/include/harfbuzz)
# 	PANGO_INCLUDE	= -I/usr/include/pango-1.0 -I/usr/include/harfbuzz
# else
# 	PANGO_INCLUDE	= -I/usr/include/pango-1.0
# endif
# else
# ifeq ($(shell /bin/ls -d $(PANGO_LIBDIR)/../include/harfbuzz 2>/dev/null),$(PANGO_LIBDIR)/../include/harfbuzz)
# 	PANGO_INCLUDE	= -I$(PANGO_LIBDIR)/../include/pango-1.0 -I$(PANGO_LIBDIR)/../include/harfbuzz
# else
# 	PANGO_INCLUDE	= -I$(PANGO_LIBDIR)/../include/pango-1.0
# endif
# endif

export CPPFLAGS=$(echo "${CPPFLAGS}" | sed "s/-O2/-O1/g")
export CFLAGS=$(echo "${CFLAGS}" | sed "s/-O2/-O1/g")
export CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-O2/-O1/g")

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
## single quotes on these two so they will be exactly as shown
echo 'INSTALL_FER_DIR = $(FER_DIR)' >> external_functions/ef_utility/site_specific.mk
echo 'FER_LOCAL_EXTFCNS = $(INSTALL_FER_DIR)/ext_func/pylibs' >> external_functions/ef_utility/site_specific.mk

# Set in conda_forge_build_setup to `${MAKEFLAGS}` and that breaks the build here.
export MAKEFLAGS=""

make FC=$FC CC=$CC LD=$FC
make install

# Activate pyferret env vars.
ACTIVATE_DIR=$PREFIX/etc/conda/activate.d
DEACTIVATE_DIR=$PREFIX/etc/conda/deactivate.d
mkdir -p $ACTIVATE_DIR
mkdir -p $DEACTIVATE_DIR

cp $RECIPE_DIR/scripts/activate.sh $ACTIVATE_DIR/pyferret-activate.sh
cp $RECIPE_DIR/scripts/activate.csh $ACTIVATE_DIR/pyferret-activate.csh
cp $RECIPE_DIR/scripts/deactivate.sh $DEACTIVATE_DIR/pyferret-deactivate.sh
cp $RECIPE_DIR/scripts/deactivate.csh $DEACTIVATE_DIR/pyferret-deactivate.csh
cp $RECIPE_DIR/scripts/pyferret $PREFIX/bin/pyferret
ln -s $PREFIX/bin/pyferret $PREFIX/bin/ferret
