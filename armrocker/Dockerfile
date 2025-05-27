FROM yufree/xcmsrocker:arm
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libmagick++-dev \
  && rm -rf /var/lib/apt/lists/* \
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
    UpSetR \
    multcomp \
    isva \ 
    h2o \
    table1 \
    flextable \
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
   && rm -rf /tmp/downloaded_packages 
    
    