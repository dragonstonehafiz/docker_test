#!/bin/bash
set -e

# Load conda
source /opt/conda/etc/profile.d/conda.sh

# Create the environment only if it doesn't exist
if ! conda env list | grep -q "gaussian_splatting"; then
    echo "Creating conda environment..."
    conda create -n gaussian_splatting python=3.9 -y
fi

# Activate the environment
conda activate gaussian_splatting

# Upgrade pip
pip install --upgrade pip

# Install PyTorch with CUDA 11.8 support
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Install Python dependencies
pip install tqdm plyfile opencv-python opencv-contrib-python

# Install CUDA extensions
pip install ./gaussian-splatting/submodules/diff-gaussian-rasterization
pip install ./gaussian-splatting/submodules/simple-knn
pip install ./gaussian-splatting/submodules/fused-ssim

echo "✅ Environment setup and extension installation complete."