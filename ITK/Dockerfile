FROM yufree/xcmsrocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && installGithub.r \
  SimpleITK/SimpleITKRInstaller \
  && rm -rf /tmp/downloaded_packages \
  && strip /usr/local/lib/R/site-library/*/libs/*
  