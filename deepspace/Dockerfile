FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && R -e "BiocManager::install(c('Cardinal','CardinalWorkflows'))" \
  && install2.r --error \
    opentimsr \
    MALDIquant \
    MALDIquantForeign \
  && installGithub.r \
    yufree/rmwf \
