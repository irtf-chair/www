# replace any mention of an RFC with a link to it

class RFCFilter < Nanoc::Filter
  identifier :rfc
  type :text

  def run(content, params={})
    content.gsub(/RFC\s*([0-9]{1,5})/i) {
      |rfc| link_to("RFC #{$1}", "http://wiki.tools.ietf.org/html/rfc#{$1}")
    }
  end
end
