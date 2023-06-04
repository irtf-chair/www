These are the sources for the https://irtf.org/ web site.

The site is being maintained as a collection of static pages via nanoc4
(http://nanoc.ws/). We use HAML (http://haml.info/) to generate HTML5, and SASS
(http://sass-lang.com/) to generate CSS.

Site content is being maintained under content/, site layouts are under
layouts/, per nanoc convention.

Run `bundle exec nanoc` to build.

In order to deploy, you need to email irtf-chair@irtf.org to upload to the IRTF
servers.
