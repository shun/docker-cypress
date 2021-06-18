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
        locales \
        fonts-noto-cjk \
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
    && locale-gen ja_JP.UTF-8 \
    && groupadd -g $GID $GROUPNAME && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME \
    && npm install -g yarn \
    && npm cache clean --force

ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8

USER $USERNAME
WORKDIR /home/$USERNAME/

RUN yarn global add cypress \
    && yarn cache clean --all
