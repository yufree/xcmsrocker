FROM yufree/deepspace:itk
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
  && rm -rf /tmp/downloaded_packages
    
RUN apt-get update \
  && R -e "BiocManager::install(c('Cardinal','CardinalWorkflows','RNiftyReg','sf','ClusterR','cluster','purrr','ggplot2','imager','umap','Matrix','igraph','tidygraph','ggraph','opentimsr','reshape2','dbscan','MALDIquantForeign'))" \
  && rm -rf /tmp/downloaded_packages \
  && strip /usr/local/lib/R/site-library/*/libs/* \
  && installGithub.r \
  nhpatterson/RegCombIMS \
  michalsta/opentims/opentimsr \
  && rm -rf /tmp/downloaded_packages \
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
