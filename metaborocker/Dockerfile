FROM yufree/xcmsrocker:latest
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
ENV miniconda3_version="py39_4.12.0"
ENV miniconda_bin_dir="/opt/miniconda/bin"
ENV PATH="${PATH}:${miniconda_bin_dir}"

RUN /rocker_scripts/install_cuda-10.1.sh
RUN /rocker_scripts/config_R_cuda.sh
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_tensorflow.sh

RUN curl -fsSLO https://repo.anaconda.com/miniconda/Miniconda3-${miniconda3_version}-Linux-x86_64.sh \
    && bash Miniconda3-${miniconda3_version}-Linux-x86_64.sh \
        -b \
        -p /opt/miniconda \
    && rm -f Miniconda3-${miniconda3_version}-Linux-x86_64.sh \
    && useradd -u 1500 -s /bin/bash miniconda \
    && chown -R miniconda:miniconda /opt/miniconda \
    && chmod -R go-w /opt/miniconda \
    && conda --version
    
RUN conda init bash \
    && conda create -n pyopenms python=3.8 \
    && conda install -c bioconda pyopenms

RUN conda init bash \
    && conda create -n matchms \
    && conda install -c bioconda matchms
    
RUN pip install numpy pandas scipy matplotlib seaborn scikit-learn plotly asari-metabolomics
 
