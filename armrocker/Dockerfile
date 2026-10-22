FROM yufree/xcmsrocker:arm0
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"
RUN R -e "bspm::disable();Sys.setenv(MAKEFLAGS = '-j8');BiocManager::install(c('remotes','xcms','IPO','WGCNA', 'KEGGREST', 'SSPA', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','metaMS', 'msPurity', 'mixOmics', 'fgsea','lumi'), ask = FALSE)" \
    && R -e "remotes::install_github(c('yufree/enviGCMS','yufree/pmd','yufree/mzrtsim','yufree/rmwf','cbroeckl/RAMClustR'), upgrade = 'never')" \
    && R -e "for (pkg in c('rwehrens/ChemometricsWithR','rwehrens/BatchCorrMetabolomics','KechrisLab/MSPrep','yufree/MetDIA','ropensci/rfigshare','Aurametrix/R/GRAPH/MetabNet','kuppal2/xMWAS','yufree/x13cms','aberHRML/classyfireR','lifs-tools/rmzTab-m')) try(remotes::install_github(pkg, upgrade = 'never'))" \
    && rm -rf /tmp/downloaded_packages \
    && strip /usr/local/lib/R/site-library/*/libs/*.so || true
