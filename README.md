# docker-opengl

| [![Build Status](https://travis-ci.org/activatedgeek/docker-opengl.svg?branch=master)](https://travis-ci.org/activatedgeek/docker-opengl) | [![](https://imagelayers.io/badge/activatedgeek/opengl:latest.svg)](https://imagelayers.io/?images=activatedgeek/opengl:latest 'Get your own badge on imagelayers.io') |
|:-:|:-:|

A full-stack Modern OpenGL S/W Rasterizer in Docker.

## Images

* `latest`, `0.1`, `0.1.1` ([Dockerfile](./Dockerfile))

## Details

This Docker image contains all the moving parts to get up and
running with Modern OpenGL (3+) on `Ubuntu 14.04 LTS` and the `Mesa` Software
Rasterizer. It contains `DRI drivers`, `OpenCV` and `PIL` for reading and writing
media files, `Freetype` for loading FreeTypes fonts, `SDL` for generating
rendering context and `numpy` for standard Matrix operations.

### High Level Specifications

* `Mesa 11.2.2` (with `swrast`)
* `Numpy` (1.11.0)
* `Pillow` (3.3.0)
* `PyOpenGL` (with `PyOpenGL-accelerate`) (3.1.0)
* `SDL2` (with `PySDL2` bindings) (0.9.3)
* `X Server` (for virtual display)

## Build

To build from source,
```
$ make devel
```
