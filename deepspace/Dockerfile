ARG CUDA_VERSION=12.6.0
FROM nvidia/cuda:${CUDA_VERSION}-base-ubuntu24.04

ENV DEBIAN_FRONTEND noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    software-properties-common \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Jupyter and ipykernel in the virtual environment
RUN pip install jupyter ipykernel

# Register the kernel with Jupyter
RUN ipython kernel install --name "python3" --user

# Install some common VS Code extensions
RUN code-server --install-extension ms-python.python \
    && code-server --install-extension ms-toolsai.jupyter

# Expose port for code-server
EXPOSE 8080

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password"]
