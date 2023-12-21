FROM rocker/geospatial:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && installGithub.r \
  yufree/rmwf \
  yufree/enviGCMS \
  yufree/pmd \
  nhpatterson/RegCombIMS \
  michalsta/opentims/opentimsr \
  && R -e "BiocManager::install(c('duckdb','RNetCDF','Cardinal','CardinalWorkflows','RNiftyReg','ClusterR','purrr','imager','umap','Rtsne','Matrix','igraph','tidygraph','ggraph','reshape2','dbscan','MALDIquantForeign','fpc','future','patchwork','ggridges','pheatmap','distances','ropls'))" \
  && R -e "devtools::install_url('https://github.com/yufree/SimpleITKRInstaller/releases/download/v2.3.0/SimpleITK_2.3.0_R_x86_64-pc-linux-gnu.tar.gz',build=F)" \
  && rm -rf /tmp/downloaded_packages \
  && rm -rf /var/lib/apt/lists/* 
    
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
