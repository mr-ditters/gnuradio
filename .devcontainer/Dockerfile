FROM mcr.microsoft.com/devcontainers/base:jammy as base

USER root

RUN apt-get update

# Needed for add-apt-repository
RUN apt install -y software-properties-common

FROM base as prod

# https://wiki.gnuradio.org/index.php?title=UbuntuInstall
RUN add-apt-repository ppa:gnuradio/gnuradio-releases
RUN apt install -y gnuradio

# On some platforms, these are required
RUN apt install -y python3-pip
RUN pip install -y packaging

CMD [ "tail", "-f", "/etc/hostname" ]

FROM base as dev_no_conda

# https://wiki.gnuradio.org/index.php/InstallingGR#From_Source


# https://wiki.gnuradio.org/index.php?title=UbuntuInstall
# Install dependencies

RUN add-apt-repository main
RUN add-apt-repository universe

# Installing gnu 3.8 deps with python 3
RUN apt install -y git cmake g++ libboost-all-dev libgmp-dev swig python3-numpy \
        python3-mako python3-sphinx python3-lxml doxygen libfftw3-dev \
        libsdl1.2-dev libgsl-dev libqwt-qt5-dev libqt5opengl5-dev python3-pyqt5 \
        liblog4cpp5-dev libzmq3-dev python3-yaml python3-click python3-click-plugins \
        python3-zmq python3-scipy python3-gi python3-gi-cairo gir1.2-gtk-3.0 \
        libcodec2-dev libgsm1-dev libusb-1.0-0 libusb-1.0-0-dev libudev-dev

# Installing gnu 3.9
RUN apt install -y pybind11-dev python3-matplotlib libsndfile1-dev python3-pip libsoapysdr-dev soapysdr-tools

RUN pip install pygccxml
RUN pip install pyqtgraph

# Installing gnu 3.10 and above
RUN apt install -y libiio-dev libad9361-dev libspdlog-dev python3-packaging python3-jsonschema

# https://wiki.gnuradio.org/index.php?title=LinuxInstall#Installing_Dependencies
# Install volk
WORKDIR /
RUN git clone --recursive https://github.com/gnuradio/volk.git
WORKDIR /volk
RUN mkdir build 
WORKDIR /volk/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python3 ../
RUN make && make test && make install
RUN ldconfig

CMD [ "tail", "-f", "/etc/hostname" ]

FROM base as dev_conda

# https://wiki.gnuradio.org/index.php?title=CondaInstall#Building_GNU_Radio_from_source_within_a_conda_environment

# https://github.com/conda-forge/miniforge-images/blob/master/ubuntu/Dockerfile
ARG MINIFORGE_NAME=Miniforge3
ARG MINIFORGE_VERSION=23.1.0-1
ARG TARGETPLATFORM

ENV CONDA_DIR=/opt/conda
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=${CONDA_DIR}/bin:${PATH}

# 1. Install just enough for conda to work
# 2. Keep $HOME clean (no .wget-hsts file), since HSTS isn't useful in this context
# 3. Install miniforge from GitHub releases
# 4. Apply some cleanup tips from https://jcrist.github.io/conda-docker-tips.html
#    Particularly, we remove pyc and a files. The default install has no js, we can skip that
# 5. Activate base by default
# 6. Activate base by default when running as root as well
#    The root user is already created, so won't pick up changes to /etc/skel
RUN apt-get update > /dev/null && \
RUN apt-get install --no-install-recommends --yes \
        wget bzip2 ca-certificates \
        git \
        tini \
        > /dev/null && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget --no-hsts --quiet https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/${MINIFORGE_NAME}-${MINIFORGE_VERSION}-Linux-$(uname -m).sh -O /tmp/miniforge.sh && \
    /bin/bash /tmp/miniforge.sh -b -p ${CONDA_DIR} && \
    rm /tmp/miniforge.sh

RUN conda clean --tarballs --index-cache --packages --yes && \
    find ${CONDA_DIR} -follow -type f -name '*.a' -delete && \
    find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete && \
    conda clean --force-pkgs-dirs --all --yes && \
    conda create -n grdev && \
    echo ". ${CONDA_DIR}/etc/profile.d/conda.sh && conda activate grdev" >> ~/.bashrc

# RUN conda create -n grdev
# RUN conda activate grdev
# RUN conda config --env --add channels conda-forge
# RUN conda config --env --set channel_priority strict

# RUN conda install alsa-lib boost-cpp click click-plugins cmake codec2 cppzmq cxx-compiler \
#         fftw gtk3 gmp gsl libad9361-iio libcblas libiio libsndfile lxml mako ninja numpy \
#         pkg-config portaudio pybind11 pybind11-abi pygobject pyqt python pyyaml pyzmq qt qwt sdl \
#         soapysdr spdlog uhd volk zeromq libice-cos6-x86_64 libselinux-cos6-x86_64 libsm-cos6-x86_64 \
#         libx11-cos6-x86_64 libxau-cos6-x86_64 libxcb-cos6-x86_64 libxdamage-cos6-x86_64 libxext-cos6-x86_64 \
#         libxfixes-cos6-x86_64 libxrender-cos6-x86_64 libxxf86vm-cos6-x86_64 libuuid-cos6-x86_64 \
#         mesa-dri-drivers-cos6-x86_64 mesa-libgl-devel-cos6-x86_64 libudev-devel-cos6-x86_64 packaging

# RUN rm $CONDA_PREFIX/lib/libudev.so.0

CMD [ "tail", "-f", "/etc/hostname" ]