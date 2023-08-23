#!/bin/bash

find . -name "*.m4v" -type f -delete
find . -name "*.pdf" -type f -delete
bundle install
bundle exec nanoc
