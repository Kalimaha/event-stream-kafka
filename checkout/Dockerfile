FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler -v 2.1.4

RUN mkdir /checkout
WORKDIR /checkout

ADD Gemfile /checkout/Gemfile
ADD Gemfile.lock /checkout/Gemfile.lock
RUN bundle install

ADD . /
