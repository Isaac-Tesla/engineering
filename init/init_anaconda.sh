#!/usr/bin/env bash

<<COMMENT

  Summary:
  The following code will install Anaconda Python on the local machine. This 
    is to enable Conda environments to be used.

  If the path isn't correctly added, this can be completed manually through 
    the following commands:

        export PATH="$HOME/anaconda3/bin/activate:$PATH"
        source~/.bashrc

COMMENT

ANACONDA_VERSION=Anaconda3-2021.11-Linux-x86_64.sh
wget https://repo.anaconda.com/archive/${ANACONDA_VERSION}
chmod +x ${ANACONDA_VERSION}
./${ANACONDA_VERSION}
rm ${ANACONDA_VERSION}