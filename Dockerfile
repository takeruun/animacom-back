FROM ruby:2.7.1-alpine3.12

RUN apk add --no-cache build-base libxml2-dev libxslt-dev \
  tzdata ca-certificates mysql-dev mysql-client \
  imagemagick imagemagick-dev imagemagick-c++ libcurl && \
  rm -rf /var/lib/apt/lists/* && \
  gem install bundler

WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /app
