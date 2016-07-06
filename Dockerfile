FROM ubuntu:14.04

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

RUN apt-get -y update &&\
  # install dependencies for Mesa DRI Drivers
  apt-get install -y --no-install-recommends \
    git curl python-dev xserver-xorg llvm-3.4-dev \
    automake autoconf libtool libpthread-stubs0-dev libva-dev &&\
  apt-get build-dep -y libgl1-mesa-dri libxcb-glx0-dev &&\
  apt-get install -y --no-install-recommends python-pip &&\
  pip install Mako &&\
  # build and install libdrm 2.4.68 from source
  curl -L http://dri.freedesktop.org/libdrm/libdrm-2.4.68.tar.bz2 -o /tmp/libdrm-2.4.68.tar.bz2 &&\
    tar xvfj /tmp/libdrm-2.4.68.tar.bz2 -C /tmp &&\
    cd /tmp/libdrm-2.4.68 &&\
    sed -i "/pthread-stubs/d" configure.ac && autoreconf -fiv &&\
    ./configure --prefix=/usr --enable-udev &&\
    make && make install &&\
  # build and install latest Mesa from source
  git clone git://anongit.freedesktop.org/git/mesa/mesa /tmp/mesa &&\
    cd /tmp/mesa &&\
    export PATH=/usr/lib/llvm-3.4/bin:$PATH &&\
    ./autogen.sh --prefix=/usr \
      --libdir=/usr/lib/x86_64-linux-gnu \
      --with-gallium-drivers=swrast \
      --without-dri-drivers \
      --disable-dri3 \
      --enable-glx-tls \
      --enable-texture-float &&\
    make && make install &&\
  # cleanup dev dependencies
  pip uninstall Mako &&\
  apt-get remove --purge \
    git curl llvm-3.4-dev automake autoconf libtool libpthread-stubs0-dev libva-dev &&\
  apt-get -y autoremove && apt-get -y autoclean &&\
  rm -rf /var/lib/apt/lists/* /tmp
