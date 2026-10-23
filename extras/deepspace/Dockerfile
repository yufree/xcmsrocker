FROM rocker/geospatial:latest
LABEL org.opencontainers.image.title="deepspace" \
      org.opencontainers.image.source="https://github.com/yufree/xcmsrocker" \
      org.opencontainers.image.authors="Miao Yu <yufreecas@gmail.com>"

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libzstd-dev \
    && rm -rf /var/lib/apt/lists/*

# Core CRAN and Bioconductor packages
RUN R -e "BiocManager::install(c('Rcpp','duckdb','RNetCDF','Cardinal','CardinalWorkflows','RNiftyReg','ClusterR','purrr','imager','umap','Rtsne','Matrix','igraph','tidygraph','ggraph','reshape2','dbscan','MALDIquantForeign','fpc','future','reticulate','RColorBrewer','patchwork','ggridges','pheatmap','distances','irlba','ropls','visNetwork','shinydashboard'), ask = FALSE)"

# Install opentimsr via author drat repository
RUN R -e "install.packages('opentimsr', repos = c('https://yufree.github.io/drat', 'https://cloud.r-project.org'))"

# Core GitHub packages for spatial reactomics
RUN installGithub.r yufree/rmwf yufree/enviGCMS yufree/pmd

# Optional legacy packages wrapped in try() to ensure resilient build across newer R versions
RUN R -e "try(remotes::install_github('nhpatterson/RegCombIMS', upgrade = 'never'))" || true
RUN R -e "try(remotes::install_github('yufree/HiTMaP', upgrade = 'never'))" || true
RUN R -e "try(devtools::install_url('https://github.com/yufree/SimpleITKRInstaller/releases/download/v2.3.0/SimpleITK_2.3.0_R_x86_64-pc-linux-gnu.tar.gz', build = FALSE))" || true
RUN rm -rf /tmp/downloaded_packages

WORKDIR /opt

# Install Miniforge
RUN wget --quiet https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O miniforge.sh && \
    chmod +x miniforge.sh && \
    bash ./miniforge.sh -b -p /opt/miniforge3 && \
    rm ./miniforge.sh

# Add Miniforge to PATH
ENV PATH="/opt/miniforge3/bin:${PATH}"
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir h5py pandas numpy matplotlib umap-learn opentims-bruker-bridge \
 && conda clean --all -y

WORKDIR /
