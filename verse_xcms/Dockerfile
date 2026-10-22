FROM yufree/xcms:latest
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"

# Install remotes and drat dependencies
RUN R -e "BiocManager::install('remotes', ask = FALSE)" \
  && R -e "install.packages(c('Autotuner','XMLSchema','SSOAP','metfRag','xMSannotator'), repos = c('https://yufree.github.io/drat', 'https://cloud.r-project.org'))"

# Install core packages
RUN R -e "remotes::install_github(c('yufree/enviGCMS','yufree/pmd','yufree/mzrtsim','yufree/rmwf','yufree/sfi','yufree/x13cms','yufree/MetDIA','cbroeckl/RAMClustR'), upgrade = 'never')"

# Install community packages with resilient fallback
RUN R -e "for (pkg in c('rwehrens/ChemometricsWithR','rwehrens/BatchCorrMetabolomics','KechrisLab/MSPrep','ropensci/rfigshare','Aurametrix/R/GRAPH/MetabNet','kuppal2/xMWAS','aberHRML/classyfireR','lifs-tools/rmzTab-m')) try(remotes::install_github(pkg, upgrade = 'never'))" \
  && rm -rf /tmp/downloaded_packages \
  && strip /usr/local/lib/R/site-library/*/libs/*.so || true
