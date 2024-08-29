ARG CUDA_VERSION=12.6.0
FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu24.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    software-properties-common \
    python3-full \
    python3-pip \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Install code-server
RUN wget https://github.com/cdr/code-server/releases/download/v4.92.2/code-server_4.92.2_amd64.deb \
    && dpkg -i code-server_4.92.2_amd64.deb \
    && rm code-server_4.92.2_amd64.deb

# Create a virtual environment and install Jupyter
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip3 install --no-cache-dir jupyter

EXPOSE 8080 8888

# Start both code-server and Jupyter Notebook
CMD code-server --bind-addr 0.0.0.0:8080 & jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root
