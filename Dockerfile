FROM ruby:2.4.2-alpine3.7
LABEL maintainer="pabloacuna88@gmail.com"

# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                tzdata

ENV APP_PATH /usr/src/app

ENV RACK_ENV=production
ENV RAILS_ENV=production

# Different layer for gems installation
WORKDIR $APP_PATH
ADD Gemfile $APP_PATH
ADD Gemfile.lock $APP_PATH
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Copy the application into the container
COPY . $APP_PATH
EXPOSE 3000

CMD bin/rails s -p 3000 -b '0.0.0.0'