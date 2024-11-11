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
        |rfc| if $1.to_i < 96 then
                link_to("IETF-#{$1}", "https://ietf.org/proceedings/#{$1}/index.html")
              elsif $1.to_i < 119 then
                link_to("IETF-#{$1}", "https://datatracker.ietf.org/meeting/#{$1}/proceedings")
              else
                link_to("IETF-#{$1}", "https://www.ietf.org/meeting/#{$1}/")
              end
      }
    end
    return doc.xpath('//body')[0].inner_html.gsub("&lt;", "<").gsub("&gt;", ">")
  end
end
