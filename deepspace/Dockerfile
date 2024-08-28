ARG CUDA_VERSION=12.6.0

FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu24.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN wget https://github.com/cdr/code-server/releases/download/v4.92.2/code-server_4.92.2_amd64.deb \
    && dpkg -i code-server_4.92.2_amd64.deb \
    && rm code-server_4.92.2_amd64.deb

EXPOSE 8080
CMD ["code-server", "--bind-addr", "0.0.0.0:8080"]
