FROM anibali/pytorch:1.5.0-cuda9.2-ubuntu18.04

USER root

RUN apt-get update && apt-get install -y git libsndfile-dev && apt-get clean

RUN git clone https://github.com/nvidia/apex /apex && \
  cd /apex && \
  pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" .
  
