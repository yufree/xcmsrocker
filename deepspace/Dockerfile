FROM rocker/geospatial:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && R -e "BiocManager::install(c('Cardinal','CardinalWorkflows','RNiftyReg','ClusterR','purrr','imager','umap','Matrix','igraph','tidygraph','ggraph','opentimsr','reshape2','dbscan','MALDIquantForeign'))" \
  && R -e "devtools::install_url('https://github.com/yufree/SimpleITKRInstaller/releases/download/v2.0.0/SimpleITK_2.0.0_R_x86_64-pc-linux-gnu.tar.gz',build=F)" \
  && rm -rf /tmp/downloaded_packages \
  && strip /usr/local/lib/R/site-library/*/libs/* \
  && installGithub.r \
  sslakkimsetty/msireg \
  nhpatterson/RegCombIMS \
  michalsta/opentims/opentimsr \
  && rm -rf /tmp/downloaded_packages \
  && rm -rf /var/lib/apt/lists/* \
  && strip /usr/local/lib/R/site-library/*/libs/*
    
WORKDIR /opt
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O anaconda3.sh && \
    chmod +x anaconda3.sh
    
RUN bash ./anaconda3.sh -b -p /opt/anaconda3 && \
    rm ./anaconda3.sh && \
    /opt/anaconda3/bin/conda create -yn timsconvert python=3.7
    
ENV PATH /opt/anaconda3/bin/:$PATH
SHELL ["conda", "run", "-n", "timsconvert", "/bin/bash", "-c"]
RUN pip install --upgrade pip
RUN git clone https://www.github.com/TheJacksonLaboratory/timsconvert
RUN pip install -r timsconvert/requirements.txt
RUN pip install git+https://github.com/gtluu/pyimzML
RUN pip install SimpleITK
