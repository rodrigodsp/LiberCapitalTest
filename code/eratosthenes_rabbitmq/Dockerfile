FROM ruby:2.6.5-slim-stretch

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

RUN echo 'gem: --no-document' > ~/.gemrc
RUN gem install bundler

ENV APP_HOME /app/
RUN mkdir $APP_HOME
COPY Gemfile Gemfile.lock $APP_HOME
WORKDIR $APP_HOME
RUN bundle install
COPY *.rb $APP_HOME