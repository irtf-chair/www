#!/bin/bash

find . -name "*.m4v" -o -name "*.pdf" -type f -delete
bundle install
bundle exec nanoc
