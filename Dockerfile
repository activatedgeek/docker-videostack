FROM ubuntu:14.04

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

RUN apt-get -y update &&\
  apt-get install -y --no-install-recommends \
    git python-dev xserver-xorg \
    automake libtool libpthread-stubs0-dev libva-dev libdrm-dev &&\
  apt-get build-dep -y libgl1-mesa-dri libxcb-glx0-dev &&\
  apt-get install -y --no-install-recommends python-pip &&\
  pip install Mako &&\
  git clone git://anongit.freedesktop.org/git/mesa/mesa /tmp/mesa &&\
  cd /tmp/mesa &&\
  export PATH=/usr/lib/llvm-3.4/bin:$PATH &&\
  # build Mesa
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
    git automake libtool libpthread-stubs0-dev libva-dev libdrm-dev &&\
  apt-get -y autoremove && apt-get -y autoclean &&\
  rm -rf /var/lib/apt/lists/* /tmp
