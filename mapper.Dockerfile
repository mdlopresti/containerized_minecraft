# Base Image
FROM ubuntu:18.04

# Add build dependency
RUN apt-get update -y && \
    apt-get install software-properties-common -y && \
    add-apt-repository ppa:deadsnakes/ppa 

RUN apt-get update -y && \
    apt-get install \
    python3 \
    python3-distutils \
    python3-pip \
    git -y
RUN python3 -m pip install pillow \
    numpy \
    networkx \
    pytest 
#     python3-pil \
#     python3-dev \
#     python3-numpy -y

# Install Overviewer
WORKDIR /usr/local/src
RUN git clone git://github.com/overviewer/Minecraft-Overviewer.git
WORKDIR /usr/local/src/Minecraft-Overviewer
RUN python3 setup.py build && \
    ln -s /usr/local/src/Minecraft-Overviewer/overviewer.py /usr/local/bin/mc-ovw

# Run Overviewer
CMD overviewer.py /world /output