FROM ruby:2.4-jessie
MAINTAINER carlosbarbiero@gmail.com

RUN apt-get update
RUN apt-get install -y qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

RUN mkdir -p /{{ APP_DIR }}

WORKDIR /{{ APP_DIR }}

ADD Gemfile /{{ APP_DIR }}/Gemfile
ADD Gemfile.lock /{{ APP_DIR }}/Gemfile.lock

ENV RAILS_ENV=production
ENV RAKE_ENV=production
ENV RAILS_LOG_TO_STDOUT=true

RUN gem install bundler && bundle install --retry 5 --without development test

ADD . /{{ APP_DIR }}

CMD ["sh", "start.sh"]