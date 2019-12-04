FROM ubuntu:latest

MAINTAINER "Robert Ladwig" rladwig2@wisc.edu # original creator: Joseph Stachelek, stachel2@msu.edu

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
	gfortran-8 \
	gfortran \ 
	libgd-dev \
	git \
	build-essential \
	libnetcdf-dev \
	ca-certificates \
	&& update-ca-certificates

RUN git clone https://github.com/robertladwig/GLM && \
	git clone https://github.com/AquaticEcoDynamics/libplot && \
	git clone https://github.com/AquaticEcoDynamics/libutil && \
	git clone https://github.com/AquaticEcoDynamics/libaed2

WORKDIR libutil

RUN F90=gfortran-8 make

WORKDIR ../libplot

RUN make

WORKDIR ../libaed2

RUN F90=gfortran-8 make

WORKDIR ../GLM

RUN FC=gfortran-8 ./build_glm.sh
