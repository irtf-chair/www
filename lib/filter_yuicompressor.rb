class YUICompressor < Nanoc3::Filter
  identifier :yuicompressor
  type :text => :binary
  
  def run(content, params={})
    if @site.config[:compress] then
      type = type_from_extension
      cmd = "/usr/local/bin/yuicompressor --type #{type} -o #{output_filename}"
    else
      cmd = "/bin/cat - > #{output_filename}"
    end
    IO.popen(cmd, 'w') { |f| f.write(content) }
    raise "'#{cmd}' exited with #{$?}" unless $? == 0
  end

  def type_from_extension
    case @item[:extension]
    when /^(css|sass|scss)/i
      "css"
    when /^js/i
      "js"
    else
      raise "unknown type for yuicompressor '#{@item[:extension]}'"
    end
  end
end