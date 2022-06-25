FROM rocker/verse:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

ENV CUDA_VERSION=10.1.243
ENV CUDA_PKG_VERSION=10-1=$CUDA_VERSION-1
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NVIDIA_REQUIRE_CUDA=cuda>=10.1 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411
ENV CUDA_HOME=/usr/local/cuda
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib64:$CUDA_HOME/extras/CUPTI/lib64:$CUDA_HOME/lib64/libnvblas.so:
ENV NVBLAS_CONFIG_FILE=/etc/nvblas.conf
ENV WORKON_HOME=/opt/venv
ENV PYTHON_VENV_PATH=/opt/venv/reticulate
ENV PYTHON_CONFIGURE_OPTS=--enable-shared
ENV RETICULATE_AUTOCONFIGURE=0
ENV PATH=${PYTHON_VENV_PATH}/bin:$PATH:${CUDA_HOME}/bin:/usr/local/texlive/bin/x86_64-linux
ENV S6_VERSION=v2.1.0.2
ENV TENSORFLOW_VERSION=gpu
ENV KERAS_VERSION=default

RUN /rocker_scripts/install_cuda-10.1.sh
RUN /rocker_scripts/config_R_cuda.sh
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_tensorflow.sh

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libnetcdf-dev \
    ## rgl support
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    ## tcl tk support
    tcl8.6-dev \
    tk8.6-dev \
  && R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS', 'msPurity', 'mixOmics', 'fgsea', 'Rita','lumi'))" \
  && install2.r --error \
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
    yufree/mz.unity \
    cbroeckl/RAMClustR \
    cran/ChemometricsWithR \
    rwehrens/BatchCorrMetabolomics \
    yufree/decoMS2 \
    KechrisLab/MSPrep \
    yufree/MetDIA \
    c-ruttkies/MetFragR/metfRag \
    ropensci/rfigshare \
    Aurametrix/R/GRAPH/MetabNet \
    kuppal2/xMWAS \
    yufree/xMSanalyzer \
    yufree/xMSannotator \
    yufree/x13cms \
    aberHRML/classyfireR \
    RforMassSpectrometry/CompoundDb \
    RforMassSpectrometry/MetaboAnnotation \
    yufree/enviGCMS \
    yufree/pmd \
    yufree/rmwf \
    