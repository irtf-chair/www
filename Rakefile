require 'nanoc3/tasks'

desc 'Compress files in output directory using htmlcompressor'
task :compress do
  # compress HTML
  sh "find output -name '*.html' -exec htmlcompressor '{}' -o '{}' \\;"

  # compress CSS
  sh "find output -name '*.css' -exec yuicompressor '{}' -o '{}' \\;"
end

desc 'Upload site with lftp'
task :deploy => [:compress] do
  srv = "sftp://ftpirtf@www.ietf.org"
  src = "~/Sites/irtf/output"
  dst = "www"
  sh "lftp -c 'open #{srv} ; mirror -RPev #{src} #{dst} '"
end
