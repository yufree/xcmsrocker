FROM rocker/r-ver:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && install2.r --error \
  remotes \
  && installGithub.r \
  sslakkimsetty/msireg \
  && rm -rf /tmp/downloaded_packages \
  && strip /usr/local/lib/R/site-library/*/libs/*
  