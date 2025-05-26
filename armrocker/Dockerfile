FROM yufree/xcmsrocker:arm
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"
RRUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    ## rgl support
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    ## tcl tk support
    tcl8.6-dev \
    tk8.6-dev \
  && rm -rf /var/lib/apt/lists/* \
  && install.r BiocManager
  && installBioc.r --error --skipinstalled \
    xcms \
    IPO \
    sva \
    WGCNA \
    KEGGREST \
    KEGGgraph \
    SSPA \
    Rdisop \
    qvalue \
    GlobalAncova \
    globaltest \
    siggenes \
    Rgraphviz \
    ChemmineR \
    metaMS \
    msPurity \
    mixOmics \
    fgsea \
    Rita \
    lumi \
    CompoundDb \
    MetaboAnnotation \
    MsBackendMgf \
    MsBackendMsp \
    genefilter \
    metapone \
  && install2.r --error --skipinstalled \
    ChemoSpec \
    webchem \
    InterpretMSSpectrum \
    tcltk2 \
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
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so
