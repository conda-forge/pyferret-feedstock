## Site-dependent definitions included in Makefiles

## !!! Also verify the values in external_functions/ef_utility/site_specific.mk !!!

## =========================
## Full path name of the directory containing this file (the ferret root directory).
## Do not use $(shell pwd) since this is included in Makefiles in other directories.
## =========================
# DIR_PREFIX = $(HOME)/build/pyferret_dev
DIR_PREFIX = $(SRC_DIR)
# DIR_PREFIX = $(HOME)/svn/pyferret

## =========================
## Installation directory for built PyFerret.  Using the "install"
## Makefile target automatically creates a generic pyferret-*.tar.gz
## file and then extracts it to create a PyFerret installation.
## =========================
# INSTALL_FER_DIR = $(HOME)/ferret_distributions/rhel6_64
# INSTALL_FER_DIR = $(HOME)/PyFerret
INSTALL_FER_DIR = $(PREFIX)

## =========================
## Machine type for which to build Ferret/PyFerret
##   x86_64-linux      for 64-bit RHEL
##   x86_64-linux-gnu  for 64-bit Ubuntu and many "free" Linux systems
##   i386-linux        for 32-bit RHEL
##   i386-linux-gnu    for 32-bit Ubuntu and many "free" Linux systems
##   intel-mac         for Mac OSX
## =========================
BUILDTYPE = $(HOSTTYPE)
# BUILDTYPE = x86_64-linux
# BUILDTYPE = x86_64-linux-gnu
# BUILDTYPE = i386-linux
# BUILDTYPE = i386-linux-gnu
# BUILDTYPE = intel-mac

## =========================
## Python executable to invoke for build and install.
## =========================
# PYTHON_EXE = python2.6
PYTHON_EXE = python
# PYTHON_EXE = python3.4
# PYTHON_EXE = python3.6

## =========================
## The assignment of PYTHONINCDIR should not need any modifications
## =========================
PYTHONINCDIR := $(shell $(PYTHON_EXE) -c "from __future__ import print_function ; import distutils.sysconfig; print(distutils.sysconfig.get_python_inc())")

## =========================
## Installation directory for cairo v1.12 or later static library
## (contains include and lib or lib64 subdirectories).  If blank,
## the system's cairo shared library will be used.  Older versions
## of cairo (v1.8 or later) can be used, but raster images from
## -nodisplay may look a little fuzzy unless -gif is specified.
## =========================
# CAIRO_DIR = /usr/local/cairo-1.14.10
# CAIRO_DIR = /usr/local/cairo-1.14.10-64
# CAIRO_DIR = /usr/local/cairo-1.14.10-32
# CAIRO_DIR = $(HOME)/.local
# CAIRO_DIR = /usr/local
CAIRO_DIR =

## =========================
## Installation directory for pixman-1 static library (contains
## include and lib or lib64 subdirectories) used by the above
## cairo library.  If blank, or if CAIRO_DIR is blank, the system's
## pixman-1 shared library will be used.
## =========================
# PIXMAN_DIR = /usr/local/pixman-0.34.0
# PIXMAN_DIR = /usr/local/pixman-0.34.0-64
# PIXMAN_DIR = /usr/local/pixman-0.34.0-32
# PIXMAN_DIR = $(HOME)/.local
# PIXMAN_DIR = /usr/local
PIXMAN_DIR =

## =========================
## Directory containing the pango-1.0, glib-2.0, freetype, fontconfig,
## png libraries (contains include and lib or lib64 subdirectory).
## If blank, or if CAIRO_DIR is blank, the system standard libraries
## will be used.
## =========================
# PANGO_DIR = $(HOME)/.local
# PANGO_DIR = /usr/local
PANGO_DIR =

## =========================
## Installation directory for HDF5 static libraries (contains include
## and lib or lib64 subdirectories).  To link to NetCDF shared-object
## libraries, do not give a location for HDF5_DIR.
## =========================
# HDF5_DIR = /usr/local/hdf5-1.8.18
# HDF5_DIR = /usr/local/hdf5-1.8.18-64
# HDF5_DIR = /usr/local/hdf5-1.8.18-32
# HDF5_DIR = $(HOME)/.local
# HDF5_DIR = /usr/local
HDF5_DIR =

## =========================
## Compression library used in the above HDF5 library, either 'z'
## or 'sz'.  If HDF5_DIR is not given, this value is not used.
## =========================
COMPRESS_LIB = z
# COMPRESS_LIB = sz

## =========================
## Installation directory for NetCDF static or shared object libraries
## (contains include and lib or lib64 subdirectories).  If HDF5_DIR
## (above) is blank, the netcdf shared-object (.so) libraries will be
## used;  otherwise the netcdf static (.a) libraries will be used.
## =========================
# NETCDF4_DIR = /usr/local/netcdf-4.4.1.1
NETCDF4_DIR = $(PREFIX)
# NETCDF4_DIR = /usr/local/netcdf-4.4.1.1-32
# NETCDF4_DIR = $(HOME)/.local
# NETCDF4_DIR = /usr/local

## =========================
## Java home directory - this may be predefined
## from your shell environment.  If JAVA_HOME is defined,
## $(JAVA_HOME)/bin/javac and $(JAVA_HOME)/bin/jar is
## called to build threddsBrowser.jar; otherwise,
## threddsBrowser.jar is not built and the Ferret command
## SET DATA /BROWSE (or the alias OPEN) will not work.
## =========================
# JAVA_HOME = /usr/java/default
# JAVA_HOME = /usr/java/latest
# JAVA_HOME = /usr/lib/jvm/default-java
# JAVA_HOME = /usr/lib/jvm/java-oracle
JAVA_HOME =
# JAVA_HOME = /Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home

##
