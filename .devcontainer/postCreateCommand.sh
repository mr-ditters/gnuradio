#! bin/bash

# Ideally, I use conda (# https://wiki.gnuradio.org/index.php?title=CondaInstall#Installing_related_software) but ran into issues.

# 1
# Couldn't find 'GL/gl.h'
# conda install mesalib

# 2
# CMake Error at gr-qtgui/lib/CMakeLists.txt:107 (target_link_libraries):
#   Target "gnuradio-qtgui" links to:

#     OpenGL::GL

#   but the target was not found.  Possible reasons include:

#     * There is a typo in the target name.
#     * A find_package call is missing for an IMPORTED target.
#     * An ALIAS target is missing.
# 

# conda create -n grdev
# conda activate grdev
# conda config --env --add channels conda-forge
# conda config --env --set channel_priority strict

# conda install alsa-lib boost-cpp click click-plugins cmake codec2 cppzmq cxx-compiler fftw gtk3 \ 
#     gmp gsl libad9361-iio libcblas libiio libsndfile lxml mako ninja numpy pkg-config portaudio \
#     pybind11 pybind11-abi pygobject pyqt python pyyaml pyzmq qt qwt sdl soapysdr spdlog uhd volk zeromq \
#     libice-cos6-x86_64 libselinux-cos6-x86_64 libsm-cos6-x86_64 libx11-cos6-x86_64 libxau-cos6-x86_64 \
#     libxcb-cos6-x86_64 libxdamage-cos6-x86_64 libxext-cos6-x86_64 libxfixes-cos6-x86_64 libxrender-cos6-x86_64 \
#     libxxf86vm-cos6-x86_64 libuuid-cos6-x86_64 mesa-dri-drivers-cos6-x86_64 mesa-libgl-devel-cos6-x86_64 \
#     libudev-devel-cos6-x86_64 packaging


# Instead, I settle for native install, but its docker :/
# https://wiki.gnuradio.org/index.php?title=UbuntuInstall#Install_Dependencies

sudo apt update

sudo apt install git cmake g++ libboost-all-dev libgmp-dev swig python3-numpy \
python3-mako python3-sphinx python3-lxml doxygen libfftw3-dev \
libsdl1.2-dev libgsl-dev libqwt-qt5-dev libqt5opengl5-dev python3-pyqt5 \
liblog4cpp5-dev libzmq3-dev python3-yaml python3-click python3-click-plugins \
python3-zmq python3-scipy python3-gi python3-gi-cairo gir1.2-gtk-3.0 \
libcodec2-dev libgsm1-dev libusb-1.0-0 libusb-1.0-0-dev libudev-dev

sudo apt install pybind11-dev python3-matplotlib libsndfile1-dev \
python3-pip libsoapysdr-dev soapysdr-tools

pip install pygccxml
pip install pyqtgraph

sudo apt install libiio-dev libad9361-dev libspdlog-dev python3-packaging python3-jsonschema
