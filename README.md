# xcmsrocker

## Rocker image for metabolomics data analysis

- For the image based on verse(Recommanded): use `docker pull yufree/xcmsrocker:latest`

- For the image based on tidyverse(smaller): use `docker pull yufree/xcmsrocker:small`

- For the image based on rstudio(tiny): use `docker pull yufree/xcmsrocker:tiny`

## Usage

1. Install Docker

2. Pull the Rocker image

3. Use `docker run --rm -p 8787:8787 yufree/xcmsrocker` to start the image

4. Open the browser and visit http://localhost:8787 or http://[your-ip-address]:8787 to power on RStudio server

5. Default user name and password are both `rstudio`

6. Enjoy your data analysis!

## Packages

- [xcms](https://bioconductor.org/packages/release/bioc/html/xcms.html)
- [CAMERA](https://bioconductor.org/packages/release/bioc/html/CAMERA.html)
- [x13cms](http://pubs.acs.org/doi/10.1021/ac403384n)
- [credential](http://pubs.acs.org/doi/abs/10.1021/ac503092d)
- [warpgroup](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btv564)
- [mz.unity](http://pubs.acs.org/doi/abs/10.1021/acs.analchem.6b01702)
- [IPO](https://bioconductor.org/packages/release/bioc/html/IPO.html)
- [apLCMS](https://sourceforge.net/projects/aplcms/)
- [xMSanalyzer](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-14-15)
- [xMSannotator](http://pubs.acs.org/doi/abs/10.1021/acs.analchem.6b01214)
- [MetaboAnalystR](https://github.com/xia-lab/MetaboAnalystR)
- [enviGCMS](https://cran.r-project.org/web/packages/enviGCMS/index.html)
