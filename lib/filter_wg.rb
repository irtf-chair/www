# replace any mention of an IETF WG with a link to its charter

class WGFilter < Nanoc3::Filter
  identifier :wg
  type :text

  # generated via: ietf-wgs | grep -v concluded | cut -d" " -f2 | fmt
  @@active = %w[
appsawg core eai httpbis hybi iri marf paws precis repute sieve
spfbis urnbis vcarddav websec weirds 6lowpan 6man ancp csi dhc dmm
dnsext hip homenet intarea l2tpext lisp lwig mif mip4 multimob
netext ntp pcp pppext savi softwire sunset4 tictoc trill 6renum
adslmib armd bmwg dime dnsop eman grow ipfix mboned netconf netmod
opsawg opsec radext v6ops atoca avtcore avtext bfcpbis bliss clue
codec cuss dispatch drinks ecrit geopriv insipid mediactrl mmusic
p2psip payload rtcweb salud simple sipclf sipcore siprec soc speechsc
straw vipr xmpp xrblock bfd ccamp forces idr isis karp l2vpn l3vpn
manet mpls nvo3 ospf pce pim pwe3 roll rtgwg sidr abfab dane emu
hokey ipsecme jose kitten krb mile nea oauth pkix tls alto behave
cdni conex dccp decade fecframe ippm ledbat mptcp nfsv4 pcn ppsp
rmt storm tcpm tsvwg
  ]

  # generated via: ietf-wgs | grep concluded | cut -d" " -f2 | fmt
  # removed: ipr
  @@concluded = %w[
822ext acap apex applmib asid atompub beep calsch calsify chronos
cdi conneg crisp dasl drums edi ediint fax find ftpext ftpext2 html
http httpstate idnabis ids imap imapext impp ipp ldapbis ldapext
ldup lemonade list lsma ltru madman marid mailext mhsds mhtml mimemhs
mimesgml mixer morg msgtrk netdata netfax nntp nntpext notary npp
oda opes osids pop prim provreg printmib quis receipt rescap schema
smtpext tn3270e telnet tftpexts tip trade urc uri urlreg urn usefor
vpim vwrap webdav webi whip widex wrec x400ops xmpp yam icar ipr
newtrk nomcom poised poised95 poisson problem 16ng addrconf ale
appleip catnip cip dna dns dnsind eap fddi frnetmib hostreq idn
ifmib ion ip1394 ipae ipatm ipdvb ipfc iplpdn ipoib iporpr ippcp
ipngwg ipv6 ipv6mib ipvbi isdnmib itrace magma mip6 mipshop mmb
mobileip monami6 mpsnmp mptrans mtudisc nemo netlmm pana pcc pip
pktway ppp rdisc send shim6 shr smds st2 svrloc tpix trunkmib tuba
vgmib zeroconf sipp acct alertman charmib chassis decnetiv ethermib
fddimib hostmib lanman modemmgt msi oim rdbmsmib snmp snmpauth
snmpv2 transmib trmon x25mib acct2 bgpdepl cidrd eii gisd ire netstat
newdom njm noop opstat ucp 2000 aaa agentx atommib bridge capwap
disman entmib eos 6bone grip hubmib imss ipcdn lsd multi6 nasreq
ngtrans pier pmol policy psamp ptomaine ptopomib radius rap rmonmib
roamops rps rwhois sming snmpconf snmpv3 upsmib osigen osinsap
osix400 skinstak thinosi avt enum ieprep iptel martini megaco sigtran
sip sipping speermint splices xcon bgp bgmp dlswmib idmr idpr ipidrp
l1vpn msdp nimrod odv pdnrout qosr rip ripv2 rolc rpsec rreq sdr
snadlc snanau ssm udlr vrrp aac aft btns cat cipso dkim dnssec
enroll ident idwgr inch ipauth ipsec ipseckey ipsp ipsra isms ispp
keyprov kink ltans mobike msec openpgp otp pem pki4ipsec sacred
sasl secsh smime snmpsec spki spwg stime syslog tnfs xmldsig wts
gsmp ipo ppvpn tewg diffserv ecm imm intserv issll ips midcom nat
nsis oncrpc malloc pilc pint pmtud rddp rohc rserpool rsvp rtfm
seamoby spirits tcpimpl tcplw tcpsat arts disi fyiup harts iafa
iiir isn iup nir nisi noctool2 noctools run ssh stdguide trainmat
userdoc userdoc2 userglos weird wnils uswg
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