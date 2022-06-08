FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get -y --no-install-recommends install \
	  libpoppler-cpp-dev \
    poppler-data \
  && apt-get install -y --no-install-recommends \
  && install2.r --error \
    --deps TRUE \
    bookdown \
    blogdown \
    xaringan \
    pkgdown \
    xfun \
    liftr \
    radix \
    citr \
    scifigure \
    pagedown \
    rolldown \
    officedown \
