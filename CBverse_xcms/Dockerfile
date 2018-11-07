FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    ## rgl support
    libglu1-mesa-dev \
  && install2.r --error \
    enviGCMS \
    nontarget \
    ChemoSpec \
    webchem \
  && R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS'))" \