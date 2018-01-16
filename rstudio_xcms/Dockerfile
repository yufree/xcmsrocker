FROM rocker/rstudio:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    libxml2-dev \
    libcairo2-dev \
    libsqlite-dev \
    libmariadbd-dev \
    libmariadb-client-lgpl-dev \
    libpq-dev \
    libssh2-1-dev \
    ## for rJava
    default-jdk \
    ## used by some base R plots
    ghostscript \
    ## used to build rJava and other packages
    libbz2-dev \
    libicu-dev \
    liblzma-dev \
    ## system dependency of hunspell (devtools)
    libhunspell-dev \
    ## rdf, for redland / linked data
    librdf0-dev \
    ## for V8-based javascript wrappers
    libv8-dev \
    ## for jq queries
    libjq-dev \
    ## R CMD Check wants qpdf to check pdf sizes, or throws a Warning 
    qpdf \
    ## for git via ssh key 
    ssh \
  && apt-get clean \
  && install2.r --error \
    --deps TRUE \
    devtools \
    remotes \
  ## from bioconductor
  && R -e "BiocInstaller::biocLite(c('xcms','IPO','WGCNA', 'SSOAP', 'KEGGREST', 'Rdisop', 'qvalue'))" \
  && installGithub.r \
    omegahat/XMLSchema \
    bdemeshev/SSOAP \
    yufree/xMSannotator \
    yufree/enviGCMS \

