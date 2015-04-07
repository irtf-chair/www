# replace any mention of an IETF WG with a link to its charter

class WGFilter < Nanoc3::Filter
  identifier :wg
  type :text

  # generated via: ietf-wgs | grep -v concluded | cut -d" " -f2 | fmt
  @@active = %w[
appsawg arcmedia calext core dmarc eppext httpbis hybi paws precis
scim tzdist urnbis uta websec ianaplan 6lo 6man 6tisch dhc dmm dnssd
dprive hip homenet intarea lwig mif mip4 netext ntp pcp savi softwire
sunset4 tictoc anima bmwg dime dnsop eman grow l3sm lime lmap mboned
netconf netmod opsawg opsec radext v6ops wpkops avtcore avtext
bfcpbis clue codec dispatch drinks ecrit insipid mmusic p2psip
payload rtcweb sipcore siprec stir stox straw webpush xmpp xrblock
bess bfd bier ccamp i2rs idr isis l2tpext lisp manet mpls nvo3 ospf
pals pce pim roll rtgwg sfc sidr spring teas trill abfab ace dane
dice httpauth ipsecme jose kitten mile oauth sacm tls tokbind trans
alto aqm cdni conex dtn ippm mptcp nfsv4 ppsp rmcat storm taps
tcpinc tcpm tram tsvwg tsvwg
  ]

  # generated via: ietf-wgs | grep concluded | cut -d" " -f2 | fmt
  # removed: ipr
  @@concluded = %w[
822ext acap apex applmib asid atompub beep calsch calsify chronos
cdi conneg crisp dasl drums eai edi ediint fax find ftpext ftpext2
html http httpstate idnabis ids imap imapext imapmove impp ipp iri
jcardcal json ldapbis ldapext ldup lemonade list lsma ltru madman
marf marid mailext mhsds mhtml mimemhs mimesgml mixer morg msgtrk
netdata netfax nntp nntpext notary npp oda opes osids pop prim
provreg printmib qresync quis receipt repute rescap schema sieve
smtpext spfbis tn3270e telnet tftpexts tip trade urc uri urlreg urn
usefor vcarddav vpim vwrap webdav webi weirds whip widex wrec x400ops
xmpp yam icar ipr newtrk nomcom poised poised95 poisson problem
16ng 6lowpan addrconf ale ancp appleip catnip cip csi dna dns dnsext
dnsind eap fddi frnetmib hostreq idn ifmib ion ip1394 ipae ipatm
ipdvb ipfc iplpdn ipoib iporpr ippcp ipngwg ipv6 ipv6mib ipvbi
isdnmib itrace magma mip6 mipshop mmb mobileip monami6 mpsnmp mptrans
mtudisc multimob nemo netlmm pana pcc pip pktway ppp pppext rdisc
send shim6 shr smds st2 svrloc tpix trunkmib tuba vgmib zeroconf
sipp acct alertman charmib chassis decnetiv ethermib fddimib hostmib
lanman modemmgt msi oim rdbmsmib snmp snmpauth snmpv2 transmib trmon
x25mib acct2 bgpdepl cidrd eii gisd ire netstat newdom njm noop
opstat ucp 2000 6renum aaa adslmib agentx armd atommib bridge capwap
disman entmib eos 6bone grip hubmib imss ipcdn ipfix lsd multi6
nasreq ngtrans pier pmol policy psamp ptomaine ptopomib radius rap
rmonmib roamops rps rwhois sming snmpconf snmpv3 upsmib osigen
osinsap osix400 skinstak thinosi atoca avt bliss cuss dart enum
geopriv ieprep iptel martini mediactrl megaco salud sigtran simple
sip sipclf sipping soc speechsc speermint splices vipr xcon bgp
bgmp dlswmib forces idmr idpr ipidrp karp l1vpn l2vpn l3vpn msdp
nimrod odv pdnrout pwe3 qosr rip ripv2 rolc rpsec rreq sdr snadlc
snanau ssm udlr vrrp aac aft btns cat cipso dkim dnssec emu enroll
hokey ident idwg inch ipauth ipsec ipseckey ipsp ipsra isms ispp
keyprov kink ltans mobike msec nea openpgp otp pem pki4ipsec pkix
sacred sasl secsh smime snmpsec spki spwg stime syslog tnfs xmldsig
wts gsmp ipo ppvpn tewg behave dccp decade diffserv ecm fecframe
imm intserv issll ips ledbat malloc midcom nat nsis oncrpc pcn pilc
pint pmtud rddp rmt rohc rserpool rsvp rtfm seamoby spirits tcpimpl
tcplw tcpsat arts disi fyiup harts iafa iiir isn iup nir nisi
noctool2 noctools run ssh stdguide trainmat userdoc userdoc2 userglos
weird wnils uswg
  ]

  def run(content, params={})
    c = content.dup
    c.gsub!(/\b(#{@@active.join('|').upcase})\b#{$boundary}/) {
      |wg| link_to($1, "http://ietf.org/dyn/wg/charter/#{$1.downcase}-charter")
    }
    c.gsub!(/\b(#{@@concluded.join('|').upcase})\b#{$boundary}/) {
      |wg| link_to($1, "http://ietf.org/wg/concluded/#{$1.downcase}")
    }
    return c
  end
end
