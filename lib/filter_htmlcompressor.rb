class HTMLCompressor < Nanoc3::Filter
  identifier :htmlcompressor
  type :text => :binary
  
  def run(content, params={})
    if @site.config[:compress] then
      type = type_from_extension
      cmd = "/usr/local/bin/htmlcompressor --type #{type} -o #{output_filename}"
    else
      cmd = "/bin/cat - > #{output_filename}"
    end
    IO.popen(cmd, 'w') { |f| f.write(content) }
    raise "'#{cmd}' exited with #{$?}" unless $? == 0
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