# xcmsrocker

Rocker image for metabolomics data analysis

[![](https://images.microbadger.com/badges/image/yufree/xcmsrocker.svg)](https://microbadger.com/images/yufree/xcmsrocker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/yufree/xcmsrocker.svg)](https://microbadger.com/images/yufree/xcmsrocker "Get your own version badge on microbadger.com")

## Usage

1. Install [Docker](https://www.docker.com/)

2. Pull the Rocker image `docker pull yufree/xcmsrocker:latest`

3. Use `docker run -e PASSWORD=rstudio -p 8787:8787 rocker/rstudio` to start the image

4. Open the browser and visit http://localhost:8787 or http://[your-ip-address]:8787 to power on RStudio server

5. Default user name and password are both `rstudio`

6. Enjoy your data analysis!

## Packages

### Peak picking

- [IPO](https://bioconductor.org/packages/release/bioc/html/IPO.html)
- [xcms](https://bioconductor.org/packages/release/bioc/html/xcms.html)
- [apLCMS](https://sourceforge.net/projects/aplcms/)
- [x13cms](http://pubs.acs.org/doi/10.1021/ac403384n)

### Peak filter/group/visulization

- [CAMERA](https://bioconductor.org/packages/release/bioc/html/CAMERA.html)
- [RAMClustR](https://pubs.acs.org/doi/abs/10.1021/ac501530d)
- [metaMS](https://www.ncbi.nlm.nih.gov/pubmed/24656939)
- [warpgroup](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btv564)
- [mz.unity](http://pubs.acs.org/doi/abs/10.1021/acs.analchem.6b01702)
- [xMSanalyzer](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-15)
- [nontarget](https://cran.r-project.org/web/packages/nontarget/index.html)
- [enviGCMS](https://cran.r-project.org/web/packages/enviGCMS/index.html)
- [ChemoSpec](https://cran.r-project.org/web/packages/ChemoSpec/index.html)
- [pmd](https://www.sciencedirect.com/science/article/pii/S0003267018313047)
- [decoMS2](https://pubs.acs.org/doi/10.1021/ac400751j)

### Batch correction

- [BatchCorrMetabolomics](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4796354/)

### Peaks annotation

- [xMSannotator](http://pubs.acs.org/doi/abs/10.1021/acs.analchem.6b01214)
- [credential](http://pubs.acs.org/doi/abs/10.1021/ac503092d)

### Statistical analysis

- [MetaboAnalystR](https://github.com/xia-lab/MetaboAnalystR)

### Chemometrics

- [rcdk](https://cran.r-project.org/web/packages/rcdk/index.html)
- [ChemmineR](https://www.bioconductor.org/packages/devel/bioc/vignettes/ChemmineR/inst/doc/ChemmineR.html)
- [webchem](https://github.com/ropensci/webchem)

## Links

- [Use docker to package your metabolomics study](https://yufree.cn/en/2018/01/17/use-docker-to-package-your-metabolomics-study/)
- [Docker Hub](https://hub.docker.com/r/yufree/xcmsrocker/)
- [Docker tutorial](http://ropenscilabs.github.io/r-docker-tutorial/)
- [Rocker](https://www.rocker-project.org/)
- [Report extra metabolomics packages or issues](https://github.com/yufree/xcmsrocker/issues)
- [Meta-Workflow](https://bookdown.org/yufree/Metabolomics/)