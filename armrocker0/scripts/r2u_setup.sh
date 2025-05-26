#!/bin/bash

## See the README.md of 'r2u' for details on these steps
##
## This script has initially been tested on a plain and minimal ubuntu:22.04, and has now been
## generalized to support 24.04 by relying on `lsb_release -cs` to echo the release name
##
## On a well-connected machine this script should take well under one minute
##
## Note that you need to run this as root

set -eu

## Zero: Sanity check
grep -q '^NAME="Ubuntu"' /etc/os-release || (echo "Not an Ubuntu system"; exit -1)

## First: update apt, install binaries we need and get keys
## Note that when testing in a container you also need to add `sudo` and `wget` first.
sudo apt update -qq && sudo DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends wget ca-certificates gnupg python3-{dbus,gi,apt} make lsb-release
wget -q -O- https://eddelbuettel.github.io/r2u/assets/dirk_eddelbuettel_key.asc | sudo tee -a /etc/apt/trusted.gpg.d/cranapt_key.asc
wget -q -O- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc

## Second: add r2u repo and CRAN's ubuntu R repo
echo "deb [arch=arm64] https://r2u.stat.illinois.edu/ubuntu "$(lsb_release -cs)" main" | sudo tee -a /etc/apt/sources.list.d/cranapt.list
echo "deb [arch=arm64] https://cloud.r-project.org/bin/linux/ubuntu "$(lsb_release -cs)"-cran40/" | sudo tee -a /etc/apt/sources.list.d/cran_r.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 67C2D66C4B1D4339 51716619E084DAB9

## Third: add pinning to ensure package sorting
echo "Package: *" | sudo tee /etc/apt/preferences.d/99cranapt
echo "Pin: release o=CRAN-Apt Project" | sudo tee -a /etc/apt/preferences.d/99cranapt
echo "Pin: release l=CRAN-Apt Packages" | sudo tee -a /etc/apt/preferences.d/99cranapt
echo "Pin-Priority: 700" | sudo tee -a /etc/apt/preferences.d/99cranapt

## Fourth: install bspm (and its Python requirements) and enable it (with speed preference)
sudo apt update -qq && sudo apt install --yes --no-install-recommends r-base-core littler r-cran-docopt
sudo Rscript -e 'install.packages("bspm")'
echo "suppressMessages(bspm::enable())" | sudo tee -a /etc/R/Rprofile.site
echo "options(bspm.version.check="${BSPM_VERSION_CHECK:-TRUE}")" | sudo tee -a /etc/R/Rprofile.site
cd /usr/local/bin
sudo ln -s /usr/lib/R/site-library/littler/examples/install.r .
sudo ln -s /usr/lib/R/site-library/littler/examples/installDeps.r .
sudo ln -s /usr/lib/R/site-library/littler/examples/installRub.r .
sudo ln -s /usr/lib/R/site-library/littler/examples/rcc.r .
sudo ln -s /usr/lib/R/site-library/littler/examples/update.r .
# in case a package gets install from source we allow writing in R package default
sudo chmod -R a+w /usr/local/lib/R/site-library
