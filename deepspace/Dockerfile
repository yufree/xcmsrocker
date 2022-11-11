FROM yufree/xcmsrocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && R -e "BiocManager::install(c('Cardinal','CardinalWorkflows'))" \
  && install2.r --error \
    MALDIquantForeign

WORKDIR /opt
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O anaconda3.sh && \
    chmod +x anaconda3.sh
    
RUN bash ./anaconda3.sh -b -p /opt/anaconda3 && \
    rm ./anaconda3.sh && \
    /opt/anaconda3/bin/conda create -yn timsconvert python=3.7
    
ENV PATH /opt/anaconda3/bin/:$PATH
RUN conda init bash
RUN conda activate timsconvert
RUN pip install --upgrade pip
RUN git clone https://www.github.com/gtluu/timsconvert
RUN pip install -r timsconvert/requirements.txt
RUN pip install git+https://github.com/gtluu/pyimzML
