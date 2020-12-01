FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu18.04

RUN apt-get update && apt-get install -y git libsndfile-dev && apt-get clean
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6

# Install Miniconda
ENV CONDA_AUTO_UPDATE_CONDA=false
RUN curl -so miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash miniconda.sh -b \
    && rm -f miniconda.sh 
    
ENV PATH=/root/miniconda3/bin:$PATH

# Install Python 3.8
RUN conda install -y python==3.8.1 \
 && conda clean -ya

# CUDA 9.2-specific steps
RUN conda install -y -c pytorch \
    cudatoolkit=9.2 \
    "pytorch=1.5.0=py3.8_cuda9.2.148_cudnn7.6.3_0" \
    "torchvision=0.6.0=py38_cu92" \
 && conda clean -ya

# Install apex
RUN git clone https://github.com/nvidia/apex /apex && \
  cd /apex && \
  pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" .
  
