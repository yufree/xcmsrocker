FROM jupyter/base-notebook:latest

# update and install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip

# install jupyterlab, pytorch and captum
RUN pip install jupyterlab torch torchvision captum

# expose port
EXPOSE 8888

# run jupyter lab
CMD ["jupyter", "lab", "--allow-root"]
