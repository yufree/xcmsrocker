FROM jupyter/base-notebook:latest

USER root

RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir \
    torch \ 
    torchvision \
    torchmetrics \
    torchviz \
    pymzml \
    captum \
    pandas

RUN python3 -m pip install git+https://github.com/gtluu/pyimzML

USER ${NB_UID}

WORKDIR "${HOME}"

# expose port
EXPOSE 8888
