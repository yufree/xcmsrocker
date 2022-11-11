FROM yufree/metaborocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && R -e "BiocManager::install(c('Cardinal','CardinalWorkflows'))" \
  && install2.r --error \
    MALDIquantForeign

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O anaconda3.sh && \
    chmod +x anaconda3.sh && \
    ./anaconda3.sh -b -p ~/anaconda3 && \
    rm ./anaconda3.sh && \
    ~/anaconda3/bin/conda create -yn timsconvert python=3.7 && \
    export PATH=~/anaconda3/bin/:$PATH && \
    source activate timsconvert
    
ENV PATH ~/anaconda3/bin/:$PATH   

RUN git clone https://www.github.com/gtluu/timsconvert
RUN pip install -r timsconvert/requirements.txt
RUN pip install git+https://github.com/gtluu/pyimzML
