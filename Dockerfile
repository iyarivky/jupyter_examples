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

# Mengklon repositori dari GitHub
RUN git clone https://github.com/iansyahr/ManimProject

# Membuat direktori font lokal
RUN mkdir -p ~/.local/share/fonts

# Menyalin font dari repositori yang telah di-klon
RUN cp ManimProject/Gelombang/Font/Rubik/static/*ttf ~/.local/share/fonts/

# Mengupdate cache font
RUN fc-cache -f -v

# Mengunduh dan mengekstrak font 'Single Day'
RUN curl -o Single+Day.zip https://cdn.glitch.global/00c5b312-7c23-48b1-af8f-a03b5f22ffd5/Single_Day.zip?v=1712100107504 && \
    unzip -o Single+Day.zip -d SingleDay && \
    mv SingleDay/*ttf ~/.local/share/fonts/ && \
    fc-cache -f -v

# Mengunduh dan mengekstrak font 'DM Serif Text'
RUN curl -o DM+Serif+Text.zip https://cdn.glitch.global/00c5b312-7c23-48b1-af8f-a03b5f22ffd5/DM_Serif_Text.zip?v=1712107269827 && \
    unzip -o DM+Serif+Text.zip -d DMSerifText && \
    cp DMSerifText/*ttf ~/.local/share/fonts/ && \
    fc-cache -f -v

# Kembali ke pengguna biasa setelah instalasi
ARG NB_USER=manimuser
USER ${NB_USER}

# Copy files dengan hak akses yang sesuai
COPY --chown=manimuser:manimuser . /manim
