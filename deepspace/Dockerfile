ARG CUDA_VERSION=12.6.0
FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \
    software-properties-common \
    dirmngr

RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
RUN apt-get update && apt-get install -y r-base r-base-dev
RUN wget https://github.com/cdr/code-server/releases/download/v3.12.0/code-server_3.12.0_amd64.deb
RUN dpkg -i code-server_3.12.0_amd64.deb
RUN pip3 install jupyter ipykernel tables h5py numpy pandac scipy scikit-learn joblib matplotlib cupy-cuda12x
RUN R -e "install.packages(c('IRkernel', 'tidyverse'), repos='http://cran.rstudio.com/')"
RUN R -e "IRkernel::installspec(user = FALSE)"
WORKDIR /workspace
RUN code-server --install-extension ms-toolsai.jupyter
RUN code-server --install-extension Ikuyadeu.r

EXPOSE 8080

CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]
