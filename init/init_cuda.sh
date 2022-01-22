#!/usr/bin/env bash


<<COMMENT

  Summary:
  The following code will install the CUDA drivers and Tensorflow GPU.

COMMENT


CUDA_FILE=cuda_10.2.89_440.33.01_linux.run
wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/${CUDA_FILE}
sudo sh ${CUDA_FILE}
rm ${CUDA_FILE}
pip install tensorflow-gpu