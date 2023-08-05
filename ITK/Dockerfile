FROM rocker/tidyverse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  cmake \
  && installGithub.r \
  sslakkimsetty/msireg \
  && rm -rf /tmp/downloaded_packages \
  && rm -rf /var/lib/apt/lists/* \
  && strip /usr/local/lib/R/site-library/*/libs/*
  