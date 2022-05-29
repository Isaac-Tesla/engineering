#!/usr/bin/env bash


<<COMMENT

  Summary:
  The following code will install Python PIP and some core libraries.

COMMENT


sudo apt install -y \
  python3-pip

pip install --no-warn-script-location \
  dbt-core \
  pandas \
  matplotlib \
  tensorflow-gpu \
  scikit-learn \
  nltk \
  numpy \
  gensim \
  great_expectations

