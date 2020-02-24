FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
WORKDIR /system

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Rails
COPY . /system
RUN bundle install
