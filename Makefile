SHELL := /bin/bash

BUILD = docker build
TARGET = tecolicom/heirloom-doctools:dev
CACHE = $(if $(NOCACHE),--no-cache)
WORK = /workdir

all:
	$(BUILD) $(CACHE) -t $(TARGET) .

run:
	@top=`git rev-parse --show-toplevel` cwd=`pwd` path=$${cwd#$$top} ; \
	command="docker run -it --rm -v $$top:$(WORK) -w $(WORK)$${path} $(TARGET) bash" ; \
	echo $$command ; \
	$$command
