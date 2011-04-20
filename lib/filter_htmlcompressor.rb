class HTMLCompressor < Nanoc3::Filter
  identifier :htmlcompressor
  type :text => :binary
  
  def run(content, params={})
    type = type_from_extension
    cmd = "/usr/local/bin/htmlcompressor --type #{type} -o #{output_filename}"
    IO.popen(cmd, 'w') { |f| f.write(content) }
    raise "htmlcompressor exited with #{$?} for '#{cmd}'" unless $? == 0
  end

  def type_from_extension
    case @item[:extension]
    when /^(haml|html)/
      "html"
    when /^xml/
      "xml"
    else
      raise "unknown type for htmlcompressor '#{@item[:extension]}'"
    end
  end
end