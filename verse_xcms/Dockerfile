FROM yufree/xcms:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && installGithub.r \
    KujawinskiLaboratory/Autotuner \
    omegahat/XMLSchema \
    cran/SSOAP \
    cbroeckl/RAMClustR \
    rwehrens/ChemometricsWithR \
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
  && rm -rf /tmp/downloaded_packages \
  && strip /usr/local/lib/R/site-library/*/libs/*.so
