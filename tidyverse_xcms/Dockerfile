FROM rocker/tidyverse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
  && R -e "BiocInstaller::biocLite(c('xcms','IPO','WGCNA', 'SSOAP', 'KEGGREST', 'Rdisop', 'qvalue'))" \
  && installGithub.r \
    omegahat/XMLSchema \
    bdemeshev/SSOAP \
    yufree/xMSannotator \
    yufree/enviGCMS \

