class HTMLCompressor < Nanoc3::Filter
  identifier :htmlcompressor
  type :text => :binary
  
  def run(content, params={})
    if @site.config[:compress] then
      type = type_from_extension
      opt = "--type #{type} --remove-intertag-spaces --remove-quotes " +
            "--simple-doctype --remove-style-attr --remove-link-attr " +
            "--remove-script-attr --remove-form-attr --remove-input-attr " +
            "--simple-bool-attr --compress-js --compress-css"
      cmd = "/usr/local/bin/htmlcompressor #{opt} -o #{output_filename}"
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