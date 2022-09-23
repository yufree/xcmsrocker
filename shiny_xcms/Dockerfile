FROM yufree/xcms:latest
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
	libgsl-dev \
  && install2.r \
	learnr \
	lubridate\
	scales \
	topicmodels \
	tidytext \
	shinyjs \
	rsconnect \
 && installGithub.r \
 	yufree/scifetch \
 	yufree/enviGCMS \
 	yufree/pmd 
RUN export ADD=shiny && bash /etc/cont-init.d/add
