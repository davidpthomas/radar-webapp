FROM ruby:2.2.2

MAINTAINER David P Thomas "dthomas@rallydev.com"

# System update
RUN apt-get update -qq && apt-get install -y build-essential
# Postgress
RUN apt-get install -y libpq-dev
# Nokogiri/XML
RUN apt-get install -y libxml2-dev libxslt1-dev
# JS Runtime
RUN apt-get install -y nodejs

# Webapp
ENV APP_HOME /apps/radar-webapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
RUN bundle install

EXPOSE 3000
