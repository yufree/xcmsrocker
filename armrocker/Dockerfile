FROM yufree/xcmsrocker:arm0
LABEL org.label-schema.license="GPL-2.0" \
      org.label-schema.vendor="xcmsrocker Project" \
      maintainer="Miao Yu <yufreecas@gmail.com>"
RUN R -e "bspm::disable();Sys.setenv(MAKEFLAGS = '-j8');BiocManager::install(c('xcms','IPO','WGCNA', 'KEGGREST', 'SSPA', 'GlobalAncova', 'globaltest', 'siggenes', 'Rgraphviz','metaMS', 'msPurity', 'mixOmics', 'fgsea','lumi'))" \
    && installGithub.r \
     cbroeckl/RAMClustR \
     rwehrens/ChemometricsWithR \
     rwehrens/BatchCorrMetabolomics \
     KechrisLab/MSPrep \
     yufree/MetDIA \
     ropensci/rfigshare \
     Aurametrix/R/GRAPH/MetabNet \
     kuppal2/xMWAS \
     yufree/x13cms \
     aberHRML/classyfireR \
     yufree/enviGCMS \
     yufree/pmd \
     yufree/mzrtsim \
     yufree/rmwf \
     lifs-tools/rmzTab-m \
   && rm -rf /tmp/downloaded_packages \
   && strip /usr/local/lib/R/site-library/*/libs/*.so
    
    