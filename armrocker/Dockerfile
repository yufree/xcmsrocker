FROM yufree/xcmsrocker:arm0
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"
RUN Rscript -e 'bspm::disable()' \
    && installBioc.r --deps TRUE --error --skipinstalled \
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
   && installGithub.r \
     cbroeckl/RAMClustR \
     rwehrens/ChemometricsWithR \
     rwehrens/BatchCorrMetabolomics \
     KechrisLab/MSPrep \
     yufree/MetDIA \
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
    
    