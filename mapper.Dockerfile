# Base Image
FROM ubuntu:18.04

ARG MINECRAFT_VERSION
ARG OVERVIEWER_VERSION

RUN apt-get update -y

# Add build dependency
RUN apt-get update -y && \
    apt-get install \
    python3 \
    python3-pil \
    python3-dev \
    python3-numpy \
    python3-pip \
    git \
    build-essential \
    wget -y

# Install Overviewer
WORKDIR /usr/local/src
RUN git clone git://github.com/overviewer/Minecraft-Overviewer.git
WORKDIR /usr/local/src/Minecraft-Overviewer
RUN git checkout tags/$OVERVIEWER_VERSION && \
    python3 setup.py build && \
    ln -s /usr/local/src/Minecraft-Overviewer/overviewer.py /usr/local/bin/mc-ovw

RUN mkdir -p ~/.minecraft/versions/$MINECRAFT_VERSION/ && \
    wget https://overviewer.org/textures/$MINECRAFT_VERSION -O ~/.minecraft/versions/$MINECRAFT_VERSION/$MINECRAFT_VERSION.jar

# Run Overviewer
CMD mc-ovw /world /output