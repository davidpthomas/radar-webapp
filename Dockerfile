FROM ruby:2.2.2

MAINTAINER David P Thomas "dthomas@rallydev.com"

# System update
RUN apt-get update -qq && apt-get install -y build-essential
# Postgress
RUN apt-get install -y libpq-dev
# Nokogiri/XML
RUN apt-get install -y libxml2-dev libxslt1-dev
# JS Runtime
RUN apt-get install -y nodejs npm
RUN ln -s /usr/bin/nodejs /usr/sbin/node

# Testing framework for JS
RUN npm install -g phantomjs

# Of course
RUN apt-get install -y vim

# ** Cache gems; bundle install will install into Bundler's vendor/bundle dir as a cache hack
# - Separate Gemfiles into their own dir logically separates Gemfiles which are far less likely
# - to change from app code reducing num of bundle installs
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

# Webapp
ENV APP_HOME /apps/radar-webapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

EXPOSE 3000

# jive with Docker tenent that a container should be the same that runs in dev/test/prod
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]

