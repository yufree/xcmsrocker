FROM jupyter/base-notebook:latest

USER root

RUN apt-get -y install git

RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir \
    torch \ 
    torchvision \
    captum

RUN python3 -m pip install git+https://github.com/gtluu/pyimzML

USER ${NB_UID}

WORKDIR "${HOME}"

# expose port
EXPOSE 8888
