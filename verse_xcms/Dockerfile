FROM yufree/xcms:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN R -e "install.packages(c('Autotuner','XMLSchema','SSOAP','metfRag','xMSannotator'), repos = 'https://yufree.github.io/drat',type = 'source')"
RUN apt-get update \
  && installGithub.r \
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
