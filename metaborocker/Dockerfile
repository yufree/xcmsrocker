FROM yufree/xcmsrocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN /rocker_scripts/install_python.sh

RUN pip install asari-metabolomics

RUN R -e "reticulate::install_miniconda(path = '/usr/local/r-miniconda', update = TRUE, force = FALSE)"

RUN R -e "Sys.setenv(RETICULATE_MINICONDA_PATH = '/usr/local/r-miniconda');reticulate::use_condaenv('base');reticulate::conda_install(packages = 'pyopenms=2.8.0',channel = c('bioconda','conda-forge'))"

RUN R -e "Sys.setenv(RETICULATE_MINICONDA_PATH = '/usr/local/r-miniconda');reticulate::use_condaenv('base');reticulate::conda_install(packages = 'matchms',channel = c('bioconda','conda-forge'))"

RUN R -e "Sys.setenv(RETICULATE_MINICONDA_PATH = '/usr/local/r-miniconda');reticulate::use_condaenv('base');reticulate::conda_install(packages = c('scipy','matplotlib','seaborn', 'scikit-learn', 'plotly'),channel = c('bioconda','conda-forge'))"
