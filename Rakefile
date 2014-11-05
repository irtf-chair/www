require 'nanoc3/tasks'

src = "output"

desc 'Compress'
task :compress do
  # compress HTML and XML
  [ "html", "xml" ].each {|d|
    sh "htmlcompressor -t " + d + " --simple-doctype --remove-style-attr --remove-link-attr --remove-script-attr --remove-form-attr --remove-input-attr --simple-bool-attr --compress-js --compress-css --preserve-php --preserve-server-script -r -o #{src}/ #{src}/"
  }
  # compress CSS and javascript
  sh "find -E #{src} -iregex '.*\.(css|js)$' -exec yuicompressor {} -o {} \\\;"
  # compress PNG/JPG/GIF - we do this when adding to the repository, no need to redo
  # sh "image_optim $(find -E #{src} -iregex '.*(jpg|gif|png)$')"
end

desc 'Upload site with lftp'
task :deploy => [ :compress ] do
  FileUtils.chmod_R "a+rX", src
  srv = "sftp://ftpirtf@ietf.org"
  dst = "www"
  sh "lftp -c 'open #{srv} ; mirror -Rv #{src} #{dst} '"
end
