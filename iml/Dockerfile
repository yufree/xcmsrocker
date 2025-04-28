FROM quay.io/jupyter/pytorch-notebook:cuda12-latest

USER root

RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir \
        torchmetrics \
        torchviz \
        pymzml \
        captum \
        pandas \
        matplotlib \
        Pillow && \
    # 3. Give back ownership of $HOME to the notebook user
    chown -R ${NB_UID}:${NB_GID} ${HOME}

USER ${NB_UID}

WORKDIR "${HOME}"

EXPOSE 8888

CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--NotebookApp.token=''", \
     "--NotebookApp.password=''"]
