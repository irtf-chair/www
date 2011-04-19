require 'nanoc3/tasks'

desc 'Upload site with lftp'
task :deploy do
  srv = "sftp://ftpirtf@www.ietf.org"
  src = "~/Sites/irtf/output"
  dst = "www"
  sh "lftp -c 'open #{srv} ; mirror -Rv #{src} #{dst} '"
end
