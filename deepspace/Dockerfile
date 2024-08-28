# 使用 ARG 指令来设置 CUDA 版本
ARG CUDA_VERSION=12.6.0

# 使用 NVIDIA CUDA 基础镜像，版本可以在构建时指定
FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu24.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    software-properties-common \
    dirmngr \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh \
    && /opt/conda/bin/conda clean -tipsy

ENV PATH=/opt/conda/bin:$PATH

RUN conda create -n gpu python=3.12 -y \
    && conda install -n gpu -c conda-forge jupyter ipykernel tables h5py numpy pandas scipy scikit-learn joblib matplotlib cupy-cuda12x \
    && conda clean -afy

RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc \
    && add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt-get update && apt-get install -y --no-install-recommends \
    r-base r-base-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && /opt/conda/bin/conda run -n gpu R -e "install.packages(c('IRkernel', 'tidyverse'), repos='http://cran.rstudio.com/')" \
    && /opt/conda/bin/conda run -n gpu R -e "IRkernel::installspec(user = FALSE)"

WORKDIR /workspace

RUN wget https://github.com/cdr/code-server/releases/download/v3.12.0/code-server_3.12.0_amd64.deb \
    && dpkg -i code-server_3.12.0_amd64.deb \
    && rm code-server_3.12.0_amd64.deb

RUN code-server --install-extension ms-toolsai.jupyter \
    && code-server --install-extension Ikuyadeu.r

ENV PATH /opt/conda/envs/gpu/bin:$PATH

EXPOSE 8080
CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]
