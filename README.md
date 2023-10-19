# IRTF Website

These are the sources for the https://www.irtf.org web site.

The site is being maintained as a collection of static pages via [nanoc4](http://nanoc.ws/).
We use [HAML](http://haml.info/) to generate HTML5, and [SASS](http://sass-lang.com/) to generate CSS.

Site content is being maintained under `content/`, site layouts are under `layouts/`, per nanoc convention.

## Build

Run `bundle exec nanoc` to build.

## Deploy

In order to deploy, you need to email irtf-chair@irtf.org to trigger a deployment.

## Installation of dependencies (on macOS):
- `brew install ruby`, following the instructions to modify your path so
  that the homebrew version of Ruby is used in preference to the system
  Ruby (`which ruby` should return `/opt/homebrew/opt/ruby/bin/ruby`).
- `bundle install` to install the required dependencies.
