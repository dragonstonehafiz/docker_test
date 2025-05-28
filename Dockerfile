FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    wget \
    curl \ 
    ninja-build \
    build-essential \
    libboost-program-options-dev \
    libboost-graph-dev \
    libboost-system-dev \
    libeigen3-dev \
    libflann-dev \
    libfreeimage-dev \
    libmetis-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libgmock-dev \
    libsqlite3-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libceres-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
RUN git clone https://github.com/colmap/colmap.git && \
    cd colmap && \
    mkdir build && \
    cd build && \
    cmake .. -GNinja -DCMAKE_CUDA_ARCHITECTURES=86 && \
    ninja && \
    ninja install

WORKDIR /workspace
# Add my test scripts
RUN git clone https://github.com/dragonstonehafiz/docker_test.git


WORKDIR /workspace
# Download and install Miniconda non-interactively
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh
# Add conda to PATH
ENV PATH=/opt/conda/bin:$PATH

# Clone the repo
WORKDIR /workspace
RUN git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive

# Create conda environment and install dependencies
# RUN conda create -n gaussian_splatting python=3.9 -y && \
#     /opt/conda/bin/conda run -n gaussian_splatting pip install --upgrade pip && \
#     /opt/conda/bin/conda run -n gaussian_splatting pip install \
#     torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 && \
#     /opt/conda/bin/conda run -n gaussian_splatting pip install \
#     tqdm \
#     plyfile \
#     opencv-python \
#     opencv-contrib-python && \
#     /opt/conda/bin/conda run -n gaussian_splatting pip install \
#     ./gaussian-splatting/submodules/diff-gaussian-rasterization \
#     ./gaussian-splatting/submodules/simple-knn \
#     ./gaussian-splatting/submodules/fused-ssim

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

CMD ["/bin/bash"]