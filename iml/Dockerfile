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
    pandas \
    pyimzml \
    matplotlib \
    Pillow \
    shutil

USER ${NB_UID}

WORKDIR "${HOME}"

# expose port
EXPOSE 8888
