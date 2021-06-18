FROM ubuntu:20.04

ARG WORKUSR=node
ARG USERNAME=$WORKUSR
ARG GROUPNAME=$WORKUSR
ARG UID=1000
ARG GID=1000
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt upgrade -y \
    && apt install -y \
        curl \
        gnupg \
        gnupg2 \
        gnupg1 \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt update \
    && apt install -y \
        google-chrome-stable \
        firefox \
        nodejs \
        libgtk2.0-0 \
        libgtk-3-0 \
        libgbm-dev \
        libnotify-dev \
        libgconf-2-4 \
        libnss3 \
        libxss1 \
        libasound2 \
        libxtst6 \
        xauth \
        xvfb \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g $GID $GROUPNAME && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME \
    && npm install -g yarn \
    && npm cache clean --force

USER $USERNAME
WORKDIR /home/$USERNAME/

RUN yarn global add cypress \
    && which cypress \
    && yarn cache clean --all \
    && which cypress \
    && cypress info
