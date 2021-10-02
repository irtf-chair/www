require 'nokogiri'

# replace any mention of an IETF WG with a link to its charter

class WGFilter < Nanoc::Filter
  identifier :wg
  type :text

  # generated via: ietf-wgs | grep -v concluded | cut -d" " -f2 | fmt
  @@active = %w[
appsawg arcmedia calext core dbound dmarc eppext httpbis hybi precis
scim tzdist urnbis uta appsawg avtcore avtext bfcpbis calext capport
cdni cellar clue codec core dbound dispatch dmarc ecrit geojson
httpbis ice insipid jsonbis justfont lager mmusic modern netvc
p2psip payload perc precis regext rtcweb scim sipcore siprec slim
stir stox straw urnbis uta webpush xrblock ianaplan 6lo 6man 6tisch
dhc dmm dnssd dprive hip homenet intarea lwig ntp pcp savi softwire
sunset4 tictoc anima bmwg dime dnsop grow l3sm lime lmap mboned
netconf netmod opsawg opsec radext supa v6ops avtcore avtext bfcpbis
clue codec dispatch drinks ecrit insipid mmusic netvc p2psip payload
rtcweb sipcore siprec stir stox straw webpush xmpp xrblock bess bfd
bier ccamp detnet i2rs idr isis l2tpext lisp manet mpls nvo3 ospf
pals pce pim roll rtgwg sfc sidr spring teas trill abfab ace acme
cose curdle dane dots httpauth i2nsf ipsecme jose kitten mile oauth
openpgp sacm tls tokbind trans alto aqm dtn ippm mptcp nfsv4 rmcat
taps tcpinc tcpm tram tsvwg tsvwg
  ]

  # generated via: ietf-wgs | grep concluded | cut -d" " -f2 | fmt
  # removed: ipr
  @@concluded = %w[
822ext acap apex applmib asid atompub beep calsch calsify chronos
cdi conneg crisp dasl drums eai edi ediint fax find ftpext ftpext2
html http httpstate idnabis ids imap imapext imapmove impp ipp iri
jcardcal json ldapbis ldapext ldup lemonade list lsma ltru madman
marf marid mailext mhsds mhtml mimemhs mimesgml mixer morg msgtrk
netdata netfax nntp nntpext notary npp oda opes osids paws pop prim
provreg printmib qresync quis receipt repute rescap schema sieve
smtpext spfbis tn3270e telnet tftpexts tip trade urc uri urlreg urn
usefor vcarddav vpim vwrap webdav webi websec weirds whip widex
wrec x400ops xmpp yam arcmedia drinks eppext hybi imapapnd tzdist
icar newtrk nomcom poised poised95 poisson problem 16ng 6lowpan
addrconf ale ancp appleip catnip cip csi dna dns dnsext dnsind eap
fddi frnetmib hostreq idn ifmib ion ip1394 ipae ipatm ipdvb ipfc
iplpdn ipoib iporpr ippcp ipngwg ipv6 ipv6mib ipvbi isdnmib itrace
magma mif mip4 mip6 mipshop mmb mobileip monami6 mpsnmp mptrans
mtudisc multimob nemo netext netlmm pana pcc pip pktway ppp pppext
rdisc send shim6 shr smds st2 svrloc tpix trunkmib tuba vgmib
zeroconf sipp acct alertman charmib chassis decnetiv ethermib fddimib
hostmib lanman modemmgt msi oim rdbmsmib snmp snmpauth snmpv2
transmib trmon x25mib acct2 bgpdepl cidrd eii gisd ire netstat
newdom njm noop opstat ucp 2000 6renum aaa adslmib agentx armd
atommib bridge capwap disman eman entmib eos 6bone grip hubmib imss
ipcdn ipfix lsd multi6 nasreq ngtrans pier pmol policy psamp ptomaine
ptopomib radius rap rmonmib roamops rps rwhois sming snmpconf snmpv3
upsmib wpkops osigen osinsap osix400 skinstak thinosi atoca avt
bliss cuss dart enum geopriv ieprep iptel martini mediactrl megaco
salud sigtran simple sip sipclf sipping soc speechsc speermint
splices vipr xcon bgp bgmp dlswmib forces idmr idpr ipidrp karp
l1vpn l2vpn l3vpn msdp nimrod odv pdnrout pwe3 qosr rip ripv2 rolc
rpsec rreq sdr snadlc snanau ssm udlr vrrp aac aft btns cat cipso
dice dkim dnssec emu enroll hokey ident idwg inch ipauth ipsec
ipseckey ipsp ipsra isms ispp keyprov kink ltans mobike msec nea
openpgp otp pem pki4ipsec pkix sacred sasl secsh smime snmpsec spki
spwg stime syslog tnfs xmldsig wts gsmp ipo ppvpn tewg behave conex
dccp decade diffserv ecm fecframe imm intserv issll ips ledbat
malloc midcom nat nsis oncrpc pcn pilc pint pmtud ppsp rddp rmt
rohc rserpool rsvp rtfm seamoby spirits storm tcpimpl tcplw tcpsat
arts disi fyiup harts iafa iiir isn iup nir nisi noctool2 noctools
run ssh stdguide trainmat userdoc userdoc2 userglos weird wnils
uswg
  ]

  def run(content, params={})
    doc = Nokogiri::HTML(content.dup)
    elements = doc.xpath('//*[local-name() != "a" and not(ancestor::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")]) and not(self::*[contains(concat(" ", normalize-space(@class), " "), " no-urlify ")])]/text()')
    elements.each do |element|
      element.content = element.content.gsub(/\b(#{@@active.join('|').upcase})\b/) {
        |wg| link_to($1, "https://datatracker.ietf.org/wg/#{$1.downcase}/charter/")
      }
      element.content = element.content.gsub(/\b(#{@@concluded.join('|').upcase})\b/) {
        |wg| link_to($1, "https://datatracker.ietf.org/wg/#{$1.downcase}/about/")
      }
    end
    return doc.xpath('//body')[0].inner_html.gsub("&lt;", "<").gsub("&gt;", ">")
  end
end
