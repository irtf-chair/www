require 'nokogiri'

# replace any mention of an RFC with a link to it

class RFCFilter < Nanoc::Filter
  identifier :rfc
  type :text

  def run(content, params={})
    doc = Nokogiri::HTML(content.dup)
    elements = doc.xpath('//*[local-name() != "a" and not(ancestor::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")])]/text()')
    elements.each do |element|
      element.content = element.content.gsub(/RFC\s*([0-9]{1,5})/i) {
        |rfc| link_to("RFC #{$1}", "https://tools.ietf.org/html/rfc#{$1}")
      }
    end
    return doc.xpath('//body')[0].inner_html.gsub("&lt;", "<").gsub("&gt;", ">")
  end
end
