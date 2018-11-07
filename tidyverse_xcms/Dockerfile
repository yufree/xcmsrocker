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
  && install2.r --error \
    enviGCMS \
    nontarget \
    ChemoSpec \
    webchem \
  && R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS'))" \
  && installGithub.r \
    omegahat/XMLSchema \
    cran/SSOAP \
    xia-lab/MetaboAnalystR \
    yufree/apLCMS \
    yufree/xMSanalyzer \
    yufree/xMSannotator \
    yufree/x13cms \
    yufree/pmd \
    nathaniel-mahieu/warpgroup \
    nathaniel-mahieu/mz.unity \
    pattilab/credential \
    cbroeckl/RAMClustR \
    rwehrens/BatchCorrMetabolomics \
    yufree/decoMS2 \
    
