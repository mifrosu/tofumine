#!/bin/bash
APP_HOME=/u/tofumine
echo Running bundle in $APP_HOME
su rubyapps -c -l "cd $APP_HOME && bundle pack --all && bundle install --local"
