#!/bin/bash

find . -name "*.m4v" -type f -delete
bundle install
bundle exec nanoc
