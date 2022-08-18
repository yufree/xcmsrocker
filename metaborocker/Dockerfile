FROM yufree/xcmsrocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN /rocker_scripts/install_python.sh

RUN pip install asari-metabolomics

RUN R -e "reticulate::install_miniconda(path = "/usr/local/bin/r-miniconda", update = TRUE, force = FALSE)"

RUN R -e "reticulate::conda_install(packages = 'pyopenms=2.8.0',channel = c('bioconda','conda-forge'))"

RUN R -e "reticulate::conda_install(packages = 'matchms',channel = c('bioconda','conda-forge'))"

RUN R -e "reticulate::conda_install(packages = c('scipy','matplotlib','seaborn', 'scikit-learn', 'plotly'),channel = c('bioconda','conda-forge'))"
