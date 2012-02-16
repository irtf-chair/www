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
    "ACM" => "http://acm.org/",
    "IEEE" => "http://ieee.org/",
    "SIGCOMM" => "http://sigcomm.org/",
    "Infocom" => "http://ieee-infocom.org/",
    "GLOBECOM" => "http://ieee-globecom.org/",
    "NSF" => "http://nsf.gov/",
    "GENI" => "http://geni.net/",
    "CoNEXT" => "http://sigcomm.org/events/conext-conference",
    "IAB" => "https://iab.org/",
    "IESG" => "http://iesg.org/",
    "IETF" => "http://ietf.org/",
    "W3C" => "http://w3.org/",
    "IRTF" => "./",
    "ISOC" => "http://isoc.org/",
    "IRTF Chair" => "chair",
    "IETF meetings?" => "http://ietf.org/meeting/",
    "IRSG" => "irsg",
    "Research Groups" => "groups",
#    "TCP" => "http://ietf.org/dyn/wg/charter/tcpm-charter",
    "RFC Editor" => "http://rfc-editor.org/",
    "ANRP" => "anrp",
    "ICIR" => "http://icir.org/",
    "HIIT" => "http://hiit.fi/",
    "LabN" => "http://labn.net/",
    "AT&T Laboratories" => "http://research.att.com/",
    "Juniper" => "http://juniper.net/",
    "Cisco" => "http://cisco.com/",
    "INRIA" => "http://www.inria.fr/", # www is needed
    "LBL" => "http://lbl.gov/",
    "USC" => "http://usc.edu/",
    "ISI" => "http://isi.edu/",
    "Nokia" => "http://nokia.com/",
    "Aalto University" => "http://aalto.fi/",
    "NetApp" => "http://www.netapp.com/us/",
    "Nokia Research Center" => "http://research.nokia.com/",
    "NEC Laboratories" => "http://www.neclab.eu/", # www is needed
    "NEC" => "http://www.neclab.eu/", # www is needed
    "UC3M" => "http://uc3m.es/",
    "Yale" => "http://yale.edu/",
    "University of Glasgow" => "http://gla.ac.uk/",
    "UCLA" => "http://ucla.edu/",
    "Colorado State" => "http://colostate.edu/",
    "UCL Louvain" => "http://uclouvain.be/",
    "DARPA" => "http://www.darpa.mil/",
    "FEDERICA" => "http://www.fp7-federica.eu/",
    "Jacobs University Bremen" => "http://www.jacobs-university.de/" # www is needed
  }

  def run(content, params={})
    c = content.dup
    @@urls.keys.sort_by {|x| x.length}.reverse.each do |tag|
      c.gsub!(/\b(#{tag})\b#{$boundary}/) {
        |x| link_to($1, @@urls[tag])
      } 
    end
    return c
  end
end