FROM rocker/tidyverse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    ## for rJava
    default-jdk \
    ## used to build rJava and other packages
    libbz2-dev \
    libicu-dev \
    liblzma-dev \
    ## used by some base R plots
    ghostscript \
    ## rgl support
    libglu1-mesa-dev \
    ## cairo support
    libxt-dev \
  && R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS'))" \
  && install2.r --error \
    --deps TRUE \
    enviGCMS \
    nontarget \
    ChemoSpec \
    webchem \