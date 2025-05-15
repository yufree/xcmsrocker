FROM rocker/geospatial:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

# R packages installation
RUN apt-get update \
  && R -e "BiocManager::install(c('Rcpp','duckdb','RNetCDF','Cardinal','CardinalWorkflows','RNiftyReg','ClusterR','purrr','imager','umap','Rtsne','Matrix','igraph','tidygraph','ggraph','reshape2','dbscan','MALDIquantForeign','fpc','future','reticulate','dbscan','RColorBrewer','patchwork','ggridges','pheatmap','distances','irlba','ropls','visNetwork','shinydashboard'))" \
  && installGithub.r \
  yufree/rmwf \
  yufree/enviGCMS \
  yufree/pmd \
  nhpatterson/RegCombIMS \
  michalsta/opentims/opentimsr \
  yufree/HiTMaP \
  && R -e "devtools::install_url('https://github.com/yufree/SimpleITKRInstaller/releases/download/v2.3.0/SimpleITK_2.3.0_R_x86_64-pc-linux-gnu.tar.gz',build=F)" \
  && rm -rf /tmp/downloaded_packages \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Install Miniforge
RUN wget --quiet https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O miniforge.sh && \
    chmod +x miniforge.sh && \
    bash ./miniforge.sh -b -p /opt/miniforge3 && \
    rm ./miniforge.sh

# Add Miniforge to PATH
ENV PATH="/opt/miniforge3/bin:${PATH}"
RUN pip install --upgrade pip
RUN pip install h5py pandas numpy matplotlib umap-learn

# Clean up conda cache to reduce image size
RUN conda clean --all -y

WORKDIR /

