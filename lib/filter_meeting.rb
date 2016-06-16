require 'nokogiri'

# replace any mention of an IETF meeting with a link to its web site

class MeetingFilter < Nanoc::Filter
  identifier :meeting
  type :text

  def run(content, params={})
    doc = Nokogiri::HTML(content.dup)
    elements = doc.xpath('//text()') - doc.xpath('//a/text()')
    elements.each do |element|
      element.content = element.content.gsub(/\bIETF-([0-9]{1,3}\b)/) {
        |rfc| link_to("IETF-#{$1}", "https://ietf.org/meeting/#{$1}/index")
      }
    end
    return doc.xpath('//body')[0].inner_html.gsub("&lt;", "<").gsub("&gt;", ">")
  end
end
