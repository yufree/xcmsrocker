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
RUN pip install jupyter ipykernel notebook

# Register the kernel with Jupyter
RUN python -m ipykernel install --user --name=python3

# Configure Jupyter
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.allow_origin = '*'" >> ~/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py

# Install some common VS Code extensions
RUN code-server --install-extension ms-python.python \
    && code-server --install-extension ms-toolsai.jupyter

# Expose ports for code-server and Jupyter
EXPOSE 8080 8888

# Start code-server and Jupyter notebook
CMD code-server --bind-addr 0.0.0.0:8080 --auth password & jupyter notebook --no-browser --port=8888 --allow-root
