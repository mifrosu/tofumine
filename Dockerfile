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

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

# Replace node with node 6.x
RUN echo 'deb https://deb.nodesource.com/node_6.x trusty main' > /etc/apt/sources.list.d/nodesource.list
RUN echo 'deb-src https://deb.nodesource.com/node_6.x trusty main' >> /etc/apt/sources.list.d/nodesource.list

# Upgrade the packages, keep old config
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

ENV RAILS_ENV="development"
ENV TERM=xterm

RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en

RUN apt-get update && apt-get install -y \
 mysql-client git-core curl zlib1g-dev build-essential libssl-dev \
 libreadline-dev libyaml-dev libxml2-dev \
 libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Container directory for volume link
RUN mkdir /u && \
mkdir -p /etc/my_init.d

## enable the local nginx instance
RUN rm -f /etc/service/nginx/down && rm /etc/nginx/sites-enabled/default
RUN ln -s  /u/config/tofumine.conf /etc/nginx/sites-enabled/tofumine.conf
RUN ln -s  /u/config/setup.sh /etc/my_init.d/setup

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc && gem install bundler

# Add the development user with a home directory
RUN useradd -m -d /home/rubyapps --uid 1000 rubyapps

WORKDIR /u/tofumine

# Clean up APT when done.
