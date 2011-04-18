# replace any mention of an RFC with a link to it

class RFCFilter < Nanoc3::Filter
  identifier :rfc
  type :text

  def run(content, params={})
    content.gsub(/RFC\s*([0-9]{1,5})/i,
                 '<a href="http://wiki.tools.ietf.org/html/rfc\1">RFC \1</a>')
  end
end