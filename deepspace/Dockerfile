FROM yufree/metaborocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && R -e "BiocManager::install(c('Cardinal','CardinalWorkflows'))" \
  && install2.r --error \
    MALDIquantForeign

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh
RUN bash Anaconda3-2021.11-Linux-x86_64.sh
RUN export PATH=$PATH:/path/to/anaconda3/bin
RUN conda create -n timsconvert python=3.7
RUN conda activate timsconvert
RUN git clone https://www.github.com/gtluu/timsconvert
RUN pip install -r timsconvert/requirements.txt
RUN pip install git+https://github.com/gtluu/pyimzML
