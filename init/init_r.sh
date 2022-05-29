#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install R and RStudio.

  Install information can be found at:
  - https://cloud.r-project.org/bin/linux/ubuntu/

  Note: Once the installation is complete, run
    "rstudio" from a terminal window.

COMMENT


sudo apt update -qq
sudo apt install -y --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo apt install -y --no-install-recommends r-base
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+

RSTUDIO_VERSION=rstudio-2021.09.1-372-amd64.deb
wget https://download1.rstudio.org/desktop/bionic/amd64/${RSTUDIO_VERSION}
sudo apt-get install -y gdebi-core
sudo gdebi ${RSTUDIO_VERSION}
rm ${RSTUDIO_VERSION}