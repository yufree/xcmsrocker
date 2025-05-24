FROM rocker/rstudio:latest

MAINTAINER "Miao Yu" yufreecas@gmail.com

ENV DEBIAN_FRONTEND=noninteractive

# Integrate r2u setup script steps
RUN \
    # Zero: Sanity check (from the original script)
    # This check will cause the build to fail if not an Ubuntu system.
    # If you are aware of the risks and want to proceed on a Debian-based system (like rocker/rstudio),
    # you might need to comment out or modify the 'exit 1' part.
    # However, r2u is specifically for Ubuntu.
    if ! grep -q '^NAME="Ubuntu"' /etc/os-release; then \
        echo "ERROR: This script and r2u are designed for Ubuntu systems." >&2; \
        echo "Current system does not appear to be Ubuntu based on /etc/os-release." >&2; \
        echo "Proceeding with rocker/rstudio (Debian-based) at your own risk if you remove/comment the exit command." >&2; \
        # exit 1; # Uncomment this line to enforce Ubuntu check strictly
    fi; \
    \
    # First: update apt, install binaries we need and get keys
    apt-get update -qq && \
    apt-get install --yes --no-install-recommends \
        wget \
        ca-certificates \
        gnupg \
        python3-dbus \
        python3-gi \
        python3-apt \
        make \
        lsb-release && \
    # Add GPG keys (Note: apt-key is deprecated)
    wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc | tee /etc/apt/trusted.gpg.d/cranapt_key.asc && \
    wget -q -O- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
    \
    # Second: add r2u repo and CRAN's ubuntu R repo
    # These URLs use $(lsb_release -cs) which will resolve to the Debian codename on this base image.
    # The r2u repository is specifically for Ubuntu codenames (e.g., jammy, noble).
    # This is a primary reason why this setup might fail or install incorrect packages on Debian.
    echo "deb [arch=amd64] https://r2u.stat.illinois.edu/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cranapt.list && \
    echo "deb [arch=amd64] https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" | tee /etc/apt/sources.list.d/cran_r.list && \
    # Add keys using apt-key (deprecated method, but used in original script)
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 67C2D66C4B1D4339 51716619E084DAB9 && \
    \
    # Third: add pinning to ensure package sorting
    echo "Package: *" > /etc/apt/preferences.d/99cranapt && \
    echo "Pin: release o=CRAN-Apt Project" >> /etc/apt/preferences.d/99cranapt && \
    echo "Pin: release l=CRAN-Apt Packages" >> /etc/apt/preferences.d/99cranapt && \
    echo "Pin-Priority: 700" >> /etc/apt/preferences.d/99cranapt && \
    \
    # Fourth: install bspm (and its Python requirements) and enable it
    apt-get update -qq && \
    apt-get install --yes --no-install-recommends \
        r-base-core \
        littler \
        r-cran-docopt && \
    # Install bspm R package
    Rscript -e 'install.packages("bspm", repos="https://cloud.r-project.org")' && \
    # Enable bspm system-wide
    echo "suppressMessages(bspm::enable())" | tee -a /etc/R/Rprofile.site && \
    echo "options(bspm.version.check=TRUE)" | tee -a /etc/R/Rprofile.site && \
    # Create symlinks for littler scripts
    # Ensure target directory exists and use -sf for force symlinking (overwrite if exists)
    mkdir -p /usr/local/bin && \
    # The path /usr/lib/R/site-library/littler assumes littler is installed via apt (e.g. r-cran-littler).
    # If littler is installed differently, this path might need adjustment.
    if [ -d "/usr/lib/R/site-library/littler/examples" ]; then \
        ln -sf /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r; \
        ln -sf /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r; \
        ln -sf /usr/lib/R/site-library/littler/examples/installDeps.r /usr/local/bin/installDeps.r; \
        ln -sf /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r; \
        ln -sf /usr/lib/R/site-library/littler/examples/installRub.r /usr/local/bin/installRub.r; \
        ln -sf /usr/lib/R/site-library/littler/examples/rcc.r /usr/local/bin/rcc.r; \
        ln -sf /usr/lib/R/site-library/littler/examples/update.r /usr/local/bin/update.r; \
    else \
        echo "Warning: Littler examples directory not found, symlinks not created." >&2; \
    fi && \
    # Allow writing in R package default directory (for source installs if bspm misses a binary)
    # This might be /usr/local/lib/R/site-library or /usr/lib/R/site-library depending on R setup
    if [ -d "/usr/local/lib/R/site-library" ]; then chmod -R a+w /usr/local/lib/R/site-library; fi && \
    if [ -d "/usr/lib/R/site-library" ]; then chmod -R a+w /usr/lib/R/site-library; fi && \
    # Clean up apt cache
    rm -rf /var/lib/apt/lists/*

RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_tidyverse.sh
RUN /rocker_scripts/install_quarto.sh

# Original system dependencies installation
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        libnetcdf-dev \
        ## rgl support
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        ## tcl tk support
        tcl8.6-dev \
        tk8.6-dev \
    && rm -rf /var/lib/apt/lists/*

# Original R package installations
# With bspm enabled, R package installations might try to use system binaries if available via apt from r2u.
RUN R -e "BiocManager::install(c('xcms','IPO','sva','WGCNA', 'KEGGREST', 'KEGGgraph', 'SSPA','Rdisop', 'qvalue', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','ChemmineR','metaMS', 'msPurity', 'mixOmics', 'fgsea', 'Rita','lumi','CompoundDb','MetaboAnnotation','MsBackendMgf','MsBackendMsp','genefilter','metapone'))" && \
    R -e "install.packages(c('ChemoSpec', 'webchem', 'InterpretMSSpectrum', 'tcltk2', 'plotly', 'caret', 'caretEnsemble', 'pROC', 'gWQS', 'enviGCMS', 'pmd', 'UpSetR', 'multcomp', 'isva', 'h2o', 'table1', 'flextable'))" && \
    R -e "install.packages(c('Autotuner','XMLSchema','SSOAP','metfRag','xMSannotator'), repos = 'https://yufree.github.io/drat',type = 'source')" &&\
    rm -rf /tmp/downloaded_packages && \
    # Strip shared object files to reduce size (from original Dockerfile)
    # Add checks to prevent errors if no .so files are found
    if compgen -G "/usr/local/lib/R/site-library/*/libs/*.so" > /dev/null; then strip /usr/local/lib/R/site-library/*/libs/*.so; fi && \
    if compgen -G "/usr/lib/R/site-library/*/libs/*.so" > /dev/null; then strip /usr/lib/R/site-library/*/libs/*.so; fi
