require 'nanoc3/tasks'

src = "~/Sites/irtf/output"

desc 'Compress'
task :compress do
  # compress HTML and XML
  [ "html", "xml" ].each {|d|
    sh "htmlcompressor -t " + d + " --simple-doctype --remove-style-attr --remove-link-attr --remove-script-attr --remove-form-attr --remove-input-attr --simple-bool-attr --compress-js --compress-css --preserve-php --preserve-server-script -r -o #{src}/ #{src}/"
  }
  # compress CSS and javascript
  sh "find -E #{src} -iregex '.*\.(css|js)$' -exec yuicompressor {} -o {} \\\;"
  # compress PNG
  sh "find #{src} -name \*png -exec optipng -quiet -strip all -o7 {} \\\;"
  # compress JPEG
  sh "find #{src} -name \*jpg -exec jpegtran -copy none -optimize -outfile {} {} \\\;"
end

desc 'Upload site with lftp'
task :deploy => [ :compress ]do
  srv = "sftp://ftpirtf@www.ietf.org"
  dst = "www"
  sh "lftp -c 'open #{srv} ; mirror -Rv #{src} #{dst} '"
end
