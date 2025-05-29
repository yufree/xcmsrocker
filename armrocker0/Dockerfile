FROM jmgirard/rstudio2u:latest
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"

ENV CTAN_REPO="https://mirror.ctan.org/systems/texlive/tlnet"
ENV PATH="$PATH:/usr/local/texlive/bin/linux"
      
COPY scripts/install_tidyverse.sh /rocker_scripts/install_tidyverse.sh
COPY scripts/install_verse.sh /rocker_scripts/install_verse.sh
COPY scripts/install_texlive.sh /rocker_scripts/install_texlive.sh
RUN chmod +x /rocker_scripts/*.sh
RUN /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_verse.sh
RUN apt-get update && apt-get install -y \
    libnetcdf-dev \
    && rm -rf /var/lib/apt/lists/*
RUN install2.r --error \
    ChemoSpec \
    webchem \
    InterpretMSSpectrum \
    tcltk2 \
    plotly \
    caret \ 
    caretEnsemble \
    pROC \
    gWQS \
    UpSetR \
    multcomp \
    isva \ 
    h2o \
    table1 \
    flextable \
    igraph \
    matrixStats \
    fastcluster \
    locfit \
    ncdf4 \
    VGAM \
    pracma \
    doSNOW \
    rgl \
    nleqslv \
    statmod \
    checkmate \
    mclust \
    rngtools \
    R.oo \
    doRNG \
    rentrez \
    R.utils \
    rjson \
    beanplot \
    nor1mix \
    reshape \
    quadprog \
    base64 \
    MALDIquant \
    estimability \
    htmlTable \
    viridis \
    colorspace \
    DEoptimR \
    rsm \
    dynamicTreeCut \
    Hmisc \
    doParallel \
    corpcor \
    dendextend \
    scrime \
    robustbase \
    ellipse \
    rARPACK \
    gsignal \
    BiocManager
RUN R -e "BiocManager::install(c('sva','Rdisop','KEGGgraph','ChemmineR', 'Rita','CompoundDb','MetaboAnnotation','MsBackendMgf','MsBackendMsp','genefilter','metapone','qvalue','Rhdf5lib','RSpectra','RBGL'))"