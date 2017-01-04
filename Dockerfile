FROM ruby:2.3.3

RUN apt-get update
RUN apt-get install -y nodejs build-essential libpq-dev postgresql-client

ENV APP_ROOT /myapp
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ADD Gemfile ${APP_ROOT}/Gemfile
ADD Gemfile.lock ${APP_ROOT}/Gemfile.lock
RUN bundle install

ADD . $APP_ROOT
