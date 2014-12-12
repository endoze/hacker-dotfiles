FROM debian:jessie
MAINTAINER chris@wideeyelabs.com

RUN apt-get update -y && apt-get install -y \
    autoconf \
    build-essential \
    curl \
    git \
    libmysqlclient-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    tmux \
    vim \
    wget \
    zlib1g-dev \
    zsh

RUN wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb && \
    dpkg -i rcm_1.2.3-1_all.deb && rm rcm_1.2.3-1_all.deb

ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
ENV SHELL /bin/zsh

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv && \
    echo 'export PATH="/root/.rbenv/bin:$PATH"; eval "$(rbenv init -)";' >> /root/.bash_profile && \
    git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build

RUN /root/.rbenv/bin/rbenv install 2.1.2 && \
    /root/.rbenv/bin/rbenv global 2.1.2 && \
    /root/.rbenv/bin/rbenv rehash

RUN curl https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > /root/.antigen.zsh

ADD . /root/.dotfiles/

RUN rcup && /bin/zsh -i -s 'source /root/.zshrc'

VOLUME ["/root/code"]
