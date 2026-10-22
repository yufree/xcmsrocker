FROM rocker/r-ver:latest
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"

RUN /rocker_scripts/install_tidyverse.sh

RUN apt-get update \
  && apt-get install -qq -y --no-install-recommends \
    libnetcdf-dev \
    ## rgl support
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    ## tcl tk support
    tcl8.6-dev \
    tk8.6-dev \
  && rm -rf /var/lib/apt/lists/* \
  && R -e "BiocManager::install(c('remotes','xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS', 'msPurity', 'mixOmics', 'fgsea', 'Rita','lumi','CompoundDb','MetaboAnnotation','MsBackendMgf','MsBackendMsp','genefilter','metapone'), ask = FALSE)" \
  && R -e "install.packages(c('Autotuner','XMLSchema','SSOAP','metfRag','xMSannotator'), repos = c('https://yufree.github.io/drat', 'https://cloud.r-project.org'))" \
  && install2.r --error \
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
    h2o

# Install core packages
RUN R -e "remotes::install_github(c('yufree/enviGCMS','yufree/pmd','yufree/mzrtsim','yufree/rmwf','cbroeckl/RAMClustR','yufree/x13cms','yufree/MetDIA'), upgrade = 'never')" \
  && R -e "for (pkg in c('rwehrens/ChemometricsWithR','rwehrens/BatchCorrMetabolomics','KechrisLab/MSPrep','ropensci/rfigshare','Aurametrix/R/GRAPH/MetabNet','kuppal2/xMWAS','aberHRML/classyfireR','lifs-tools/rmzTab-m')) try(remotes::install_github(pkg, upgrade = 'never'))" \
  && rm -rf /tmp/downloaded_packages \
  && strip /usr/local/lib/R/site-library/*/libs/*.so || true
