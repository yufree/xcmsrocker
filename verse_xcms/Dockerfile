FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
  && R -e "BiocInstaller::biocLite(c('xcms','IPO','WGCNA', 'SSOAP', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz'))" \
  && installGithub.r \
    omegahat/XMLSchema \
    bdemeshev/SSOAP \
    yufree/xMSannotator \
    yufree/xMSanalyzer \
    yufree/apLCMS \
    yufree/enviGCMS \
    xia-lab/MetaboAnalystR \
    yufree/x13cms \
    nathaniel-mahieu/warpgroup \
    nathaniel-mahieu/mz.unity \

