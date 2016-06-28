require 'nokogiri'

# replace any mention of an IRTF RG with a link to its charter

class RGFilter < Nanoc::Filter
  identifier :rg
  type :text

  def run(content, params={})
    doc = Nokogiri::HTML(content.dup)
    elements = doc.xpath('//*[local-name() != "a" and not(ancestor::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")])]/text()')
    elements.each do |element|
      element.content = element.content.gsub(/\b(#{$rgs.keys.join('|').upcase})\b/) {
        |rg| link_to($1, "/#{$1.downcase}")
      }
      element.content = element.content.gsub(/\b(#{$oldrgs.keys.join('|').upcase})\b/) {
        |rg| link_to($1, "/concluded/#{$1.downcase}")
      }
    end
    return doc.xpath('//body')[0].inner_html.gsub("&lt;", "<").gsub("&gt;", ">")
  end
end
