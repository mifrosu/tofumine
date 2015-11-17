# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
#FROM phusion/passenger-full:<VERSION>
# Or, instead of the 'full' variant, use one of these:
#FROM phusion/passenger-ruby19:<VERSION>
#FROM phusion/passenger-ruby20:<VERSION>
#FROM phusion/passenger-ruby21:<VERSION>
FROM phusion/passenger-ruby22:0.9.17
#FROM phusion/passenger-jruby90:<VERSION>
#FROM phusion/passenger-nodejs:<VERSION>
#FROM phusion/passenger-customizable:<VERSION>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
#RUN /pd_build/utilities.sh
#   Ruby support.
#RUN /pd_build/ruby1.9.sh
#RUN /pd_build/ruby2.0.sh
#RUN /pd_build/ruby2.1.sh
#RUN /pd_build/ruby2.2.sh
#RUN /pd_build/jruby9.0.sh
#   Python support.
#RUN /pd_build/python.sh
#   Node.js and Meteor support.
#RUN /pd_build/nodejs.sh

# ...put your own build instructions here...


ENV RAILS_ENV="development"

RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en

RUN apt-get update && apt-get install -y \
 mysql-client git-core curl zlib1g-dev build-essential libssl-dev \
 libreadline-dev libyaml-dev libxml2-dev \
 libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev \
 nodejs

## enable the local nginx instance
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-available/default
COPY tofumine.conf /etc/nginx/sites-enabled/tofumine.conf

## Container directory for volume link
RUN mkdir /u
RUN ln -s /u/tofumine /home/app/tofumine
# RUN mkdir -p /home/app/app_files && chown app:app /home/app/app_files

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install bundler

## the Gemfiles for caching:
# COPY app_files/Gemfile /home/app/app_files
# COPY app_files/Gemfile.lock /home/app/app_files
# RUN gem install bundler && bundle install --jobs 20 --retry 5

## the image source
# COPY ./app_files /home/app/app_files/

WORKDIR /home/app/tofumine

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
