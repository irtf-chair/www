# replace a few commonly used terms with hyperlinks

class URLFilter < Nanoc3::Filter
  identifier :url
  type :text

  @@urls = {
    "Gnutella" => "http://en.wikipedia.org/wiki/Gnutella",
    "BitTorrent" => "http://en.wikipedia.org/wiki/BitTorrent",
    "eDonkey" => "http://en.wikipedia.org/wiki/EDonkey_network",
    "eMule" => "http://en.wikipedia.org/wiki/Emule",
    "Skype" => "http://en.wikipedia.org/wiki/Skype",
    "ACM" => "http://www.acm.org/",
    "IEEE" => "http://www.ieee.org/",
    "SIGCOMM" => "http://www.sigcomm.org/",
    "INFOCOM" => "http://www.ieee-infocom.org/",
    "GLOBECOM" => "http://www.ieee-globecom.org/",
    "NSF" => "http://www.nsf.gov/",
    "GENI" => "http://www.geni.net/",
    "CoNEXT" => "http://www.sigcomm.org/events/conext-conference",
    "IAB" => "https://www.iab.org/",
    "IESG" => "http://www.iesg.org/",
    "IETF" => "http://www.ietf.org/",
    "W3C" => "http://www.w3.org/",
    "IRTF" => "./",
    "ISOC" => "http://www.isoc.org/",
    "IRTF Chair" => "chair",
    "IETF meetings?" => "http://www.ietf.org/meeting/",
    "IRSG" => "irsg",
    "Research Groups" => "groups",
#    "TCP" => "http://www.ietf.org/dyn/wg/charter/tcpm-charter",
    "RFC Editor" => "http://www.rfc-editor.org/",
    "ANRP" => "anrp"
  }

  def run(content, params={})
    @@urls.keys.sort_by {|x| x.length}.reverse.each do |tag|
      t = Regexp.new($boundary + '(' + tag + ')' + $boundary)
      content.gsub!(t, '\1<a href="' + @@urls[tag] + '">\2</a>\3')
    end
    return content
  end
end