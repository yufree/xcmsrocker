FROM rocker/rstudio:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    libxml2-dev \
    libcairo2-dev \
    libssh2-1-dev \
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
    ## for git via ssh key 
    ssh \
  && apt-get clean \
  && install2.r --error \
    --deps TRUE \
    devtools \
    remotes \
    shiny \
    BiocManager \
  ## from bioconductor
  && R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS'))" \
  && install2.r --error \
    --deps TRUE \
    enviGCMS \
    nontarget \
    ChemoSpec \
    webchem \