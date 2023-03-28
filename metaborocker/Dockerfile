FROM yufree/xcmsrocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN /rocker_scripts/install_python.sh

RUN pip install asari-metabolomics rdkit

# Install Conda
RUN apt-get update && apt-get install -y wget bzip2 \
    && wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda clean -ya \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc

# Create Conda environments
RUN /opt/conda/bin/conda create -y -n openms -c bioconda python=3.9 pyopenms 

RUN /opt/conda/bin/conda create -y -n matchms -c bioconda matchms

# Set environment variables for R
ENV RETICULATE_PYTHON /opt/conda/bin/python

# Install reticulate package in R
RUN Rscript -e 'install.packages("reticulate")'
