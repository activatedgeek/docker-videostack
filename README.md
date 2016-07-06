# docker-opengl

| [![Build Status](https://travis-ci.org/activatedgeek/docker-opengl.svg?branch=master)](https://travis-ci.org/activatedgeek/docker-opengl) | [![](https://imagelayers.io/badge/activatedgeek/opengl:latest.svg)](https://imagelayers.io/?images=activatedgeek/opengl:latest 'Get your own badge on imagelayers.io') |
|:-:|:-:|

A full-stack Modern OpenGL S/W Rasterizer in Docker on `Ubuntu 14.04`.

## Images

* `latest`, `0.1`, `0.1.0` ([Dockerfile](./Dockerfile))

## Details

This Docker image contains all the moving parts to get up and
running with Modern OpenGL (3+) on `Ubuntu 14.04 LTS` and the `Mesa` Software
Rasterizer. It contains `DRI drivers`, `OpenCV` and `PIL` for reading and writing
media files, `Freetype` for loading FreeTypes fonts, `SDL` for generating
rendering context and `numpy` for standard Matrix operations.

### High Level Specifications

* `Mesa 12.0.0-rc4` (with `swrast`)
* `libdrm` (2.4.68)
* `Numpy` (1.11.0)
* `Pillow` (3.3.0)
* `PyOpenGL` (with `PyOpenGL-accelerate`) (3.1.0)
* `SDL2` (with `PySDL2` bindings) (0.9.3)

## Usage

### Pull Image from Docker Hub
```
$ docker pull activatedgeek/opengl
```

### Run Container

**NOTE**: An X Server must be independently run on the host. Also, the X server
must be allowed access from remote hosts via `xhost +` (or equivalent secure versions).

The image can then be run as:
```
$ docker run -it --privileged \
  -e "DISPLAY=unix:0.0" \
  -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  activatedgeek/opengl bash
```

This will open up the bash terminal, with the `DISPLAY` set to the hosts display
socket. It should be run in privileged mode.

## Build

To build from source,
```
$ make devel
```
