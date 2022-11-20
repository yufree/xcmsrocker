FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    ## rgl support
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    ## tcl tk support
    tcl8.6-dev \
    tk8.6-dev \
  && R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS', 'msPurity', 'mixOmics', 'fgsea', 'Rita','lumi','CompoundDb','MetaboAnnotation','MsBackendMgf','MsBackendMsp','genefilter','metapone'))" \
  && install2.r --error \
    ChemoSpec \
    webchem \
    InterpretMSSpectrum \
    tcltk2 \
    ROCS \
    plotly \
    caret \ 
    caretEnsemble \
    pROC \
    gWQS \
    enviGCMS \
    pmd \
    UpSetR \
    multcomp \
    isva \ 
    h2o \
    table1 \
    flextable \
    && rm -rf /tmp/downloaded_packages
    && strip /usr/local/lib/R/site-library/*/libs/*.so
