##
# Makefile for development environments
##

devel: Dockerfile
	@docker build -t activatedgeek/mesa:devel .
