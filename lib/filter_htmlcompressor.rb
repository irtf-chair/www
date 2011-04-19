class HTMLCompressor < Nanoc3::Filter
  identifier :htmlcompressor
  type :text => :binary
  
  def run(content, params={})
    cmd = "/usr/local/bin/htmlcompressor -o #{output_filename}"
    IO.popen(cmd, 'w') { |f| f.write(content) }
    raise "htmlcompressor exited with #{$?} for '#{cmd}'" unless $? == 0
  end
end