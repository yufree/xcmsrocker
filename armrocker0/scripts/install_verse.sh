#!/bin/bash
set -e

## build ARGs
NCPUS=${NCPUS:--1}

# shellcheck source=/dev/null
source /etc/os-release

# always set this for scripts but don't declare as ENV..
export DEBIAN_FRONTEND=noninteractive

# a function to install apt packages only if they are not installed
function apt_install() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
}

apt_install \
    cmake \
    curl \
    default-jdk \
    fonts-roboto \
    ghostscript \
    hugo \
    less \
    libbz2-dev \
    libglpk-dev \
    libgmp3-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libhunspell-dev \
    libicu-dev \
    liblzma-dev \
    libmagick++-dev \
    libopenmpi-dev \
    libpcre2-dev \
    libssl-dev \
    libv8-dev \
    libxml2-dev \
    libxslt1-dev \
    libzmq3-dev \
    qpdf \
    texinfo \
    software-properties-common \
    vim \
    wget

# libgit2-dev also depends on the libcurl4-gnutils in bionic but not on focal
# cran PPA is a super-stable solution to this
if [ "${UBUNTU_CODENAME}" == "bionic" ]; then
    add-apt-repository -y ppa:cran/travis
fi

# librdf0-dev depends on libcurl4-gnutils-dev instead of libcurl4-openssl-dev...
# So: we can build the redland package bindings and then swap back to libcurl-openssl-dev... (ick)
# explicitly install runtime library sub-deps of librdf0-dev so they are not auto-removed.
apt_install librdf0-dev
install2.r --error --skipinstalled -n "$NCPUS" redland
apt_install \
    libcurl4-openssl-dev \
    libgit2-dev \
    libxslt-dev \
    librdf0 \
    redland-utils \
    rasqal-utils \
    raptor2-utils

apt-get remove -y systemd
apt-get -y autoremove

## Add LaTeX, rticles and bookdown support
## tinytex recommends a dummy texlive if using tlmgr manually
if [[ ! -x "/usr/bin/latex" ]]; then
    apt_install equivs
    cd /tmp
    wget https://github.com/scottkosty/install-tl-ubuntu/raw/master/debian-control-texlive-in.txt
    equivs-build debian-*
    mv texlive-local*.deb texlive-local.deb
    dpkg -i texlive-local.deb
    rm debian-control-texlive-in.txt
    apt-get -y purge equivs
    apt-get -y autoremove
fi

## Install texlive
/rocker_scripts/install_texlive.sh

install2.r --error --skipinstalled -n "$NCPUS" tinytex
install2.r --error --deps TRUE --skipinstalled -n "$NCPUS" \
    blogdown \
    bookdown \
    distill \
    rticles \
    rJava \
    xaringan

# Clean up
rm -rf /tmp/downloaded_packages
rm -rf /var/lib/apt/lists/*
