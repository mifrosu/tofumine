# TofuMine

An application developed following the Hands-on with React and Ruby on Rails
course by Jonathan Lebensold and published by O'Reilly Media.

http://shop.oreilly.com/product/0636920044307.do

This is a Restaurant review application, with comments.

Not part of the course: This project includes a development Dockerfile,
which creates a user called rubyapps. This user has a UID of 1000; the idea
being that the container will be used by the local user with that UID. It
adds the local source directory as a volume, and allows the docker user
privileged access---it can run bundle install, etc. *Not for production*.
The UID can be changed if you are not 1000. phusion/passenger is used as a
base image:

https://github.com/phusion/passenger-docker

A docker-compose file is included for convenience. It uses a separate mysql
container with a mounted volume for local storage.
