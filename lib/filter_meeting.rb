require 'nokogiri'

# replace any mention of an IETF meeting with a link to its web site

class MeetingFilter < Nanoc::Filter
  identifier :meeting
  type :text

  def run(content, params={})
    doc = Nokogiri::HTML(content.dup)
    elements = doc.xpath('//*[local-name() != "a" and not(ancestor::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")]) and not(self::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")])]/text()')
    elements.each do |element|
      element.content = element.content.gsub(/\bIETF-([0-9]{1,3}\b)/) {
        |rfc| link_to("IETF-#{$1}", "https://ietf.org/how/meetings/#{$1}/")
      }
    end
    return doc.xpath('//body')[0].inner_html.gsub("&lt;", "<").gsub("&gt;", ">")
  end
end
