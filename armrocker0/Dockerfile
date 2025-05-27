FROM rocker/r-ver:latest as source
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"

FROM rocker/r2u:focal
COPY --from=source /rocker_scripts /rocker_scripts
RUN /rocker_scripts/install_rstudio.sh

ENV CTAN_REPO="https://mirror.ctan.org/systems/texlive/tlnet"
ENV PATH="$PATH:/usr/local/texlive/bin/linux"
      
COPY scripts/install_tidyverse.sh /rocker_scripts/install_tidyverse.sh
COPY scripts/install_verse.sh /rocker_scripts/install_verse.sh
COPY scripts/install_texlive.sh /rocker_scripts/install_texlive.sh

RUN chmod +x /rocker_scripts/*.sh
RUN /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_verse.sh
