FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.9 and essential utilities
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    ca-certificates \
    && ln -sf python3.9 /usr/bin/python3 \
    && ln -sf python3.9 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm /tmp/miniconda.sh && \
    conda init bash

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

CMD ["/bin/bash"]