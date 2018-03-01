#!/usr/bin/env bash
 
WORK_DIR="/tmp/libvirt"
 
sudo apt update
sudo apt install -y git
 
# LIBVIRT
 
WORK_DIR_LIBVIRT="$WORK_DIR/libvirt"
mkdir -p $WORK_DIR_LIBVIRT
cd $WORK_DIR_LIBVIRT
 
LIBVIRT_VERSION="v4.0.0"
git clone -b $LIBVIRT_VERSION --single-branch --depth 1 https://github.com/libvirt/libvirt.git .
git checkout $LIBVIRT_VERSION
 
sudo apt install -y \
    gettext \
    libtool \
    autoconf \
    autopoint \
    pkg-config \
    xsltproc \
    libxml2-utils
./bootstrap
 
sudo apt install -y \
    libnl-3-dev \
    libnl-route-3-dev \
    libxml2-dev \
    libdevmapper-dev \
    libpciaccess-dev \
    python
./configure
 
sudo apt install -y intltool
aclocal
 
make
sudo make install
 
 
# LIBVIRT PYTHON
 
WORK_DIR_LIBVIRT_PYTHON="$WORK_DIR/python"
mkdir -p $WORK_DIR_LIBVIRT_PYTHON
cd $WORK_DIR_LIBVIRT_PYTHON
 
LIBVIRT_PYTHON_VERSION="v4.0.0"
git clone -b $LIBVIRT_PYTHON_VERSION --single-branch --depth 1 https://github.com/libvirt/libvirt-python .
git checkout $LIBVIRT_PYTHON_VERSION
 
sudo apt install -y python-dev
 
python setup.py build
python setup.py install
 
 
# CLEANUP
 
rm -r $WORK_DIR
sudo apt purge -y \
    gettext \
    libtool \
    autoconf \
    autopoint \
    pkg-config \
    xsltproc \
    libxml2-utils \
    libnl-3-dev \
    libnl-route-3-dev \
    libxml2-dev \
    libdevmapper-dev \
    libpciaccess-dev \
    intltool \
    python-dev
