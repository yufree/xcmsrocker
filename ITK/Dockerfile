FROM rocker/r-ver:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  cmake \
  git \
  &&install2.r \
  devtools \
  && R -e "devtools::install_github('SimpleITK/SimpleITKRInstaller', configure.vars = 'MAKEJ=2')" \
  && rm -rf /tmp/downloaded_packages \
  && rm -rf /var/lib/apt/lists/* \
  && strip /usr/local/lib/R/site-library/*/libs/*
  