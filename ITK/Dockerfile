FROM rocker/rstudio:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com
RUN apt-get update \
  && installGithub.r \
  sslakkimsetty/msireg \
  && rm -rf /tmp/downloaded_packages \
  && rm -rf /var/lib/apt/lists/* \
  && strip /usr/local/lib/R/site-library/*/libs/*
  