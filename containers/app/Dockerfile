FROM ruby:2.7.1-alpine3.12

ENV TZ=Asia/Tokyo \
  RAILS_ENV=production \
  RAILS_SERVE_STATIC_FILES=false

RUN apk add --no-cache build-base libxml2-dev libxslt-dev \
  tzdata ca-certificates mysql-dev mysql-client \
  imagemagick imagemagick-dev imagemagick-c++ libcurl && \
  rm -rf /var/lib/apt/lists/* && \
  gem install bundler

WORKDIR /app

RUN mkdir -p tmp/sockets
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle config set without 'test development' && \
  bundle install

ADD . /app

CMD bundle exec puma -C config/puma.rb