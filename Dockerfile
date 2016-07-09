FROM ubuntu:14.04

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

RUN apt-get -y update &&\
  apt-get install -y --no-install-recommends \
    software-properties-common \
    python-software-properties &&\
  add-apt-repository -y ppa:mc3man/trusty-media &&\
  # needed for libfaac-dev
  echo "deb http://us.archive.ubuntu.com/ubuntu trusty main multiverse" >> /etc/apt/sources.list &&\
  apt-get -y update &&\
  # install dependencies for Mesa DRI Drivers
  apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    libav-tools \
    libavcodec-extra \
    libfreetype6-dev \
    libfaac-dev \
    libjpeg-dev \
    libsdl2-dev \
    libsox-fmt-mp3 \
    python \
    python-pip \
    python-opencv \
    sox \
    zlib1g-dev &&\
  ln -s /usr/lib/x86_64-linux-gnu/libfaac.so /usr/lib &&\
  ln -s /usr/lib/x86_64-linux-gnu/libfreetype.so /usr/lib &&\
  ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib &&\
  ln -s /usr/lib/x86_64-linux-gnu/libz.so /usr/lib &&\
  pip install \
    azure==0.11.1 \
    django-dotenv==1.4.1 \
    freetype-py==1.0.2 \
    numpy==1.11.0 \
    pika==0.10.0 \
    Pillow==3.3.0 \
    py-expression-eval==0.3.2 \
    PyMySQL==0.7.5 \
    PyOpenGL==3.1.0 \
    PyOpenGL-accelerate==3.1.0 \
    PySDL2==0.9.3 \
    python-dateutil==2.4.2 \
    requests==2.10.0 \
    supervisor==3.2.0 &&\
  apt-get remove --purge -y \
    software-properties-common \
    python-software-properties &&\
  apt-get -y autoremove && apt-get -y autoclean &&\
  rm -rf /var/lib/apt/lists/* /tmp/*
