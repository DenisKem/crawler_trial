FROM ruby:2.7.1

COPY source/Gemfile /app/
WORKDIR /app
RUN bundle install
COPY source /app
