FROM rocker/rstudio:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

COPY scripts/r2u_setup.sh /rocker_scripts/r2u_setup.sh
RUN /rocker_scripts/r2u_setup.sh

COPY scripts/install_tidyverse.sh /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_tidyverse.sh

ENV CTAN_REPO="https://mirror.ctan.org/systems/texlive/tlnet"
ENV PATH="$PATH:/usr/local/texlive/bin/linux"

COPY scripts/install_verse.sh /rocker_scripts/install_verse.sh
COPY scripts/install_texlive.sh /rocker_scripts/install_texlive.sh
RUN /rocker_scripts/install_verse.sh
