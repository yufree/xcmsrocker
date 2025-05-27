FROM jmgirard/rstudio2u:latest
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"

ENV CTAN_REPO="https://mirror.ctan.org/systems/texlive/tlnet"
ENV PATH="$PATH:/usr/local/texlive/bin/linux"
      
COPY scripts/install_tidyverse.sh /rocker_scripts/install_tidyverse.sh
COPY scripts/install_verse.sh /rocker_scripts/install_verse.sh
COPY scripts/install_texlive.sh /rocker_scripts/install_texlive.sh

RUN /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_verse.sh
RUN install2.r --error \
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
    h2o \
    table1 \
    flextable 