class YUICompressor < Nanoc3::Filter
  identifier :yuicompressor
  type :text => :binary
  
  def run(content, params={})
    type = type_from_extension
    cmd = "/usr/local/bin/yuicompressor --type #{type} -o #{output_filename}"
    IO.popen(cmd, 'w') { |f| f.write(content) }
    raise "yuicompressor exited with #{$?} for '#{cmd}'" unless $? == 0
  end

  def type_from_extension
    case @item[:extension]
    when /^(css|sass|scss)/
      "css"
    when /^js/
      "js"
    else
      raise "unknown type for yuicompressor '#{@item[:extension]}'"
    end
  end
end