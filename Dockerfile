FROM ubuntu:14.04

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

RUN apt-get -y update &&\
  # needed for libfaac-dev
  echo "deb http://us.archive.ubuntu.com/ubuntu trusty main multiverse" >> /etc/apt/sources.list &&\
  apt-get -y update &&\
  # install dependencies for Mesa DRI Drivers
  apt-get install -y --no-install-recommends \
    git \
    curl \
    python-dev \
    python-opencv \
    llvm-3.4-dev \
    automake \
    autoconf \
    libtool \
    libsdl2-dev \
    libpthread-stubs0-dev \
    libva-dev \
    libdrm-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libfaac-dev &&\
  apt-get build-dep -y libgl1-mesa-dri libxcb-glx0-dev &&\
  ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib &&\
  ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib &&\
  ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib &&\
  ln -s /usr/lib/x86_64-linux-gnu/libfaac.so /usr/lib &&\
  apt-get install -y --no-install-recommends python-pip &&\
  pip install \
    numpy==1.11.0 \
    Pillow==3.3.0 \
    PyOpenGL==3.1.0 \
    PyOpenGL-accelerate==3.1.0 \
    PySDL2==0.9.3 \
    freetype-py==1.0.2 \
    Mako &&\
  # build and install latest DRM from source
  curl -L http://dri.freedesktop.org/libdrm/libdrm-2.4.68.tar.bz2 -o /tmp/libdrm-2.4.68.tar.bz2 &&\
    tar xvfj /tmp/libdrm-2.4.68.tar.bz2 -C /tmp &&\
    cd /tmp/libdrm-2.4.68 &&\
    sed -i "/pthread-stubs/d" configure.ac &&\
    autoreconf -fiv &&\
    ./configure --prefix=/usr --enable-udev &&\
    make && make install &&\
  # build and install latest Mesa from source
  git clone git://anongit.freedesktop.org/git/mesa/mesa /tmp/mesa &&\
    cd /tmp/mesa &&\
    git checkout mesa-12.0.0-rc4 &&\
    export PATH=/usr/lib/llvm-3.4/bin:$PATH &&\
    ./autogen.sh --prefix=/usr \
      --libdir=/usr/lib/x86_64-linux-gnu \
      --with-gallium-drivers=swrast \
      --without-dri-drivers \
      --disable-dri3 \
      --enable-glx-tls \
      --enable-texture-float &&\
    make && make install &&\
  cd / &&\
  # cleanup dev dependencies
  pip uninstall -y Mako &&\
  apt-get remove --purge -y \
    git \
    curl \
    llvm-3.4-dev \
    automake \
    autoconf &&\
  apt-get -y autoremove && apt-get -y autoclean &&\
  rm -rf /var/lib/apt/lists/* /tmp/*
