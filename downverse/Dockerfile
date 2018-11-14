FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
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
