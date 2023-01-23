FROM jupyter/base-notebook:latest

# update and install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip

# install jupyterhub and pytorch
RUN pip install jupyterhub torch torchvision

# install captum
RUN pip install captum

# copy config files
COPY jupyterhub_config.py /etc/jupyterhub/

# expose port
EXPOSE 8000

# run jupyterhub
CMD ["jupyterhub", "-f", "/etc/jupyterhub/jupyterhub_config.py"]
