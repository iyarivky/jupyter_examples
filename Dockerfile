FROM manimcommunity/manim:v0.18.1

# Gunakan pengguna root untuk instalasi paket
USER root

# Update package list dan instal paket yang diperlukan
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    ffmpeg \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instal Jupyter notebook
RUN pip install notebook

# Kembali ke pengguna biasa setelah instalasi
ARG NB_USER=manimuser
USER ${NB_USER}

# Copy files dengan hak akses yang sesuai
COPY --chown=manimuser:manimuser . /manim
