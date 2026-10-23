# syntax=docker/dockerfile:1
#
# xcmsrocker — one Dockerfile, five chained stages.
#
#   cran ─▶ bioc ─▶ sif ─▶ rstudio ─▶ metabo
#                    │        │          └─ yufree/metaborocker:latest
#                    │        └─ yufree/xcmsrocker:latest (also :arm)
#                    └─ yufree/xcmsrocker:sif   (headless, for HPC/Singularity)
#
# Locally the whole chain builds in one go:
#   docker build --target rstudio -t xcmsrocker .
#
# On GitHub Actions each stage runs as its own job (6 h limit per job). The job
# overrides the previous stage with the image pushed by the previous job via
#   --build-context <prev-stage>=docker-image://ghcr.io/.../xcmsrocker-stages:<prev-stage>-<arch>
# so only one stage is compiled per job. See .github/workflows/build.yml.

ARG R_BASE=rocker/r-ver:latest

########################################################################
# Stage 1 — tidyverse, system libraries and CRAN packages
########################################################################
FROM ${R_BASE} AS cran
LABEL org.opencontainers.image.title="xcmsrocker" \
      org.opencontainers.image.description="Rocker image for metabolomics data analysis" \
      org.opencontainers.image.source="https://github.com/yufree/xcmsrocker" \
      org.opencontainers.image.licenses="GPL-2.0" \
      org.opencontainers.image.authors="Miao Yu <yufreecas@gmail.com>"

RUN /rocker_scripts/install_tidyverse.sh

COPY pkgs/apt.txt /opt/xcmsrocker/pkgs/apt.txt
RUN apt-get update \
 && sed -e 's/#.*//' /opt/xcmsrocker/pkgs/apt.txt | xargs apt-get install -y --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

COPY scripts/install_pkgs.R /opt/xcmsrocker/install_pkgs.R
COPY pkgs/cran.txt /opt/xcmsrocker/pkgs/cran.txt
RUN Rscript /opt/xcmsrocker/install_pkgs.R cran /opt/xcmsrocker/pkgs/cran.txt \
 && rm -rf /tmp/downloaded_packages \
 && (strip /usr/local/lib/R/site-library/*/libs/*.so || true)

########################################################################
# Stage 2 — Bioconductor (heaviest compile)
########################################################################
FROM cran AS bioc
COPY scripts/install_pkgs.R /opt/xcmsrocker/install_pkgs.R
COPY pkgs/bioc.txt /opt/xcmsrocker/pkgs/bioc.txt
RUN Rscript /opt/xcmsrocker/install_pkgs.R bioc /opt/xcmsrocker/pkgs/bioc.txt \
 && rm -rf /tmp/downloaded_packages \
 && (strip /usr/local/lib/R/site-library/*/libs/*.so || true)

########################################################################
# Stage 3 — drat + GitHub packages  ==>  xcmsrocker:sif (no RStudio)
########################################################################
FROM bioc AS sif
COPY scripts/install_pkgs.R /opt/xcmsrocker/install_pkgs.R
COPY pkgs/drat.txt /opt/xcmsrocker/pkgs/drat.txt
RUN Rscript /opt/xcmsrocker/install_pkgs.R drat /opt/xcmsrocker/pkgs/drat.txt \
 && rm -rf /tmp/downloaded_packages

COPY pkgs/github.txt /opt/xcmsrocker/pkgs/github.txt
RUN --mount=type=secret,id=github_pat \
    Rscript /opt/xcmsrocker/install_pkgs.R github /opt/xcmsrocker/pkgs/github.txt \
 && rm -rf /tmp/downloaded_packages \
 && (strip /usr/local/lib/R/site-library/*/libs/*.so || true)

CMD ["R"]

########################################################################
# Stage 4 — RStudio Server + pandoc/quarto + TeX Live  ==>  xcmsrocker:latest
# Same steps as rocker/verse, applied on top of the package stack.
########################################################################
FROM sif AS rstudio
ENV S6_VERSION="v2.1.0.2" \
    RSTUDIO_VERSION="stable" \
    DEFAULT_USER="rstudio" \
    CTAN_REPO="https://mirror.ctan.org/systems/texlive/tlnet"
ENV PATH="${PATH}:/usr/local/texlive/bin/linux"

RUN /rocker_scripts/install_rstudio.sh \
 && /rocker_scripts/install_pandoc.sh \
 && /rocker_scripts/install_quarto.sh
RUN /rocker_scripts/install_verse.sh

EXPOSE 8787
CMD ["/init"]

########################################################################
# Stage 5 — Python via reticulate  ==>  metaborocker:latest
########################################################################
FROM rstudio AS metabo
ENV VIRTUAL_ENV="/opt/venv"
ENV PATH="${VIRTUAL_ENV}/bin:${PATH}"

# Creates /opt/venv, installs reticulate and exports PATH/VIRTUAL_ENV to
# Renviron.site so RStudio sessions pick the venv up automatically.
RUN /rocker_scripts/install_python.sh

COPY pkgs/python.txt /opt/xcmsrocker/pkgs/python.txt
RUN pip install --no-cache-dir -r /opt/xcmsrocker/pkgs/python.txt \
 && chown -R root:staff "${VIRTUAL_ENV}" \
 && chmod -R g+ws "${VIRTUAL_ENV}"
