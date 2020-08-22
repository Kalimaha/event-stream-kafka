FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN gem install bundler -v 2.1.4

RUN mkdir /kitchen
WORKDIR /kitchen

ADD Gemfile /kitchen/Gemfile
ADD Gemfile.lock /kitchen/Gemfile.lock
RUN bundle install

ADD . /
