FROM ubuntu:18.04

RUN apt-get update -y

ARG MINECRAFT_VERSION

RUN apt-get update -y && \
    apt-get install \
    cron -y

COPY backup.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh