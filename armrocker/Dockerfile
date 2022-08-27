FROM rocker/r-ver:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

ENV S6_VERSION=v2.1.0.2
ENV RSTUDIO_VERSION=daily
ENV DEFAULT_USER=rstudio
ENV PANDOC_VERSION=default
ENV PATH=/usr/lib/rstudio-server/bin:$PATH

RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_pandoc.sh

EXPOSE 8787

CMD ["/init"]

RUN /rocker_scripts/install_tidyverse.sh
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    ## rgl support
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    ## tcl tk support
    tcl8.6-dev \
    tk8.6-dev \
  && R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS', 'msPurity', 'mixOmics', 'fgsea', 'Rita','lumi','CompoundDb','MetaboAnnotation','MsBackendMgf','MsBackendMsp','genefilter'))" \
  && install2.r --error \
    BiocManager \
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
  && installGithub.r \
    KujawinskiLaboratory/Autotuner \
    omegahat/XMLSchema \
    cran/SSOAP \
    cbroeckl/RAMClustR \
    cran/ChemometricsWithR \
    rwehrens/BatchCorrMetabolomics \
    KechrisLab/MSPrep \
    yufree/MetDIA \
    c-ruttkies/MetFragR/metfRag \
    ropensci/rfigshare \
    Aurametrix/R/GRAPH/MetabNet \
    kuppal2/xMWAS \
    yufree/xMSannotator \
    yufree/x13cms \
    aberHRML/classyfireR \
    yufree/enviGCMS \
    yufree/pmd \
    yufree/rmwf \
    lifs-tools/rmzTab-m \
    