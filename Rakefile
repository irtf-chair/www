require 'nanoc3/tasks'

desc 'Compress files in output directory using htmlcompressor'
task :compress do
  # compress HTML
  sh "find output -name '*.html' -print -exec htmlcompressor '{}' -o '{}' \\;"

  # compress HTML
  sh "find output -name '*.xml' -print -exec htmlcompressor '{}' -o '{}' \\;"

  # compress CSS
  sh "find output -name '*.css' -print -exec yuicompressor '{}' -o '{}' \\;"
end

desc 'Upload site with lftp'
task :deploy => [:compress] do
  srv = "sftp://ftpirtf@www.ietf.org"
  src = "~/Sites/irtf/output"
  dst = "www"
  sh "lftp -c 'open #{srv} ; mirror -Rv #{src} #{dst} '"
end
