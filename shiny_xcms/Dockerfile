FROM rocker/shiny-verse:latest
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

# Copy configuration files into the Docker image
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY /apps /srv/shiny-server/
# Make the ShinyApp available at port 80
EXPOSE 80
# Copy further configuration files into the Docker image
COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]
CMD ["/usr/bin/shiny-server.sh"]
