FROM yufree/metaborocker:latest
MAINTAINER "Miao Yu" yufreecas@gmail.com

RUN apt-get update \
  && R -e "BiocManager::install(c('Cardinal','CardinalWorkflows'))" \
  && install2.r --error \
    MALDIquantForeign \
  
RUN git clone https://www.github.com/gtluu/timsconvert

RUN pip install -r timsconvert/requirements.txt

RUN pip install git+https://github.com/gtluu/pyimzML
