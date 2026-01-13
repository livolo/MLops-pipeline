FROM continuumio/miniconda3

# Set working directory inside container
WORKDIR /app

# Copy environment file
COPY envs/rnaseq.yaml /app/envs/rnaseq.yaml

# Create conda environment
RUN conda env create -f /app/envs/rnaseq.yaml

# Use rnaseq environment by default
SHELL ["conda", "run", "-n", "rnaseq", "/bin/bash", "-c"]

# Install MLOps tools
RUN conda install -c conda-forge mlflow dvc -y

# Copy project files
COPY . /app

# Default command
CMD ["bash"]

