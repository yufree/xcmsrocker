FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    ## rgl support
    libglu1-mesa-dev \
  && R -e "BiocInstaller::biocLite(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR'))" \
  && installGithub.r \
    omegahat/XMLSchema \
    cran/SSOAP \
    yufree/enviGCMS \
    xia-lab/MetaboAnalystR \
    yufree/apLCMS \
    yufree/xMSanalyzer \
    yufree/xMSannotator \
    yufree/x13cms \
    yufree/pmd \
    nathaniel-mahieu/warpgroup \
    nathaniel-mahieu/mz.unity \
    pattilab/credential \
    blosloos/nontarget \
    bryanhanson/ChemoSpec \
    rwehrens/metaMS \
    cbroeckl/RAMClustR \
    ropensci/webchem \
    rwehrens/BatchCorrMetabolomics \
    yufree/decoMS2 \
