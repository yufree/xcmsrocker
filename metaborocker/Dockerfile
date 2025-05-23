FROM yufree/xcmsrocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

# Install Miniforge
RUN wget --quiet https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O miniforge.sh && \
    chmod +x miniforge.sh && \
    bash ./miniforge.sh -b -p /opt/miniforge3 && \
    rm ./miniforge.sh

# Add Miniforge to PATH
ENV PATH="/opt/miniforge3/bin:${PATH}"
RUN pip install --upgrade pip
RUN pip install h5py pandas numpy matplotlib umap-learn asari-metabolomics rdkit matchms pyopenms 

# Clean up conda cache to reduce image size
RUN conda clean --all -y

WORKDIR /
