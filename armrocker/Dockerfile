FROM rocker/rstudio:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com
RUN /rocker_scripts/install_pandoc.sh

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libxml2-dev \
    libcairo2-dev \
    libgit2-dev \
    default-libmysqlclient-dev \
    libpq-dev \
    libsasl2-dev \
    libsqlite3-dev \
    libssh2-1-dev \
    libxtst6 \
    libcurl4-openssl-dev \
    unixodbc-dev
  
RUN install2.r --error --skipinstalled \
    devtools \
    rmarkdown \
    BiocManager \
    vroom \
    gert
    
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/downloaded_packages

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
  && R -e "install.packages(c('Autotuner','XMLSchema','SSOAP','metfRag','xMSannotator'), repos = 'https://yufree.github.io/drat',type = 'source')" \
  && install2.r --error  --skipinstalled \
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
    UpSetR \
    multcomp \
    isva \ 
    h2o \
    RAMClustR \
  && installGithub.r \
    rwehrens/ChemometricsWithR \
    rwehrens/BatchCorrMetabolomics \
    KechrisLab/MSPrep \
    yufree/MetDIA \
    c-ruttkies/MetFragR/metfRag \
    ropensci/rfigshare \
    Aurametrix/R/GRAPH/MetabNet \
    kuppal2/xMWAS \
    yufree/x13cms \
    aberHRML/classyfireR \
    yufree/enviGCMS \
    yufree/pmd \
    yufree/mzrtsim \
    yufree/rmwf \
    lifs-tools/rmzTab-m \
   && rm -rf /tmp/downloaded_packages \
   && strip /usr/local/lib/R/site-library/*/libs/*.so
