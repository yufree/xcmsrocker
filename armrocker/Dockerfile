FROM yufree/xcmsrocker:arm
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"
RUN mkdir -p /etc/R && touch /etc/R/Rprofile.site
RUN sed -i '/suppressMessages(bspm::enable())/i options(bspm.sudo = TRUE)' /etc/R/Rprofile.site
RUN Rscript -e "install.packages(c('ChemoSpec', 'webchem', 'InterpretMSSpectrum', 'tcltk2', 'plotly', 'caret', 'caretEnsemble', 'pROC', 'gWQS', 'UpSetR', 'multcomp', 'isva', 'h2o', 'table1', 'flextable'))" \
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
    
    