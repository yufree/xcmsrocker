FROM yufree/xcms:latest
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
 && R -e "BiocManager::install(c('genefilter'))" \
 && installGithub.r \
 	yufree/enviGCMS \
 	yufree/pmd 
RUN export ADD=shiny && bash /etc/cont-init.d/add
