FROM ruby:2.5.1-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential libpq-dev imagemagick curl

RUN apt-get install -y gnupg

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn
      
ENV INSTALL_PATH /amigo_secreto

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile ./

ENV BUNDLE_PATH /box

COPY . .