# replace any mention of an IETF WG with a link to its charter

class WGFilter < Nanoc3::Filter
  identifier :wg
  type :text

  # generated via: ietf-wgs | grep -v concluded | cut -d" " -f2 | fmt
  @@active = %w[
    appsawg core eai ftpext2 httpbis httpstate hybi iri marf precis
    sieve urnbis vcarddav vwrap websec yam 6lowpan 6man ancp autoconf
    csi dhc dnsext hip intarea ipdvb l2tpext lisp lwig mext mif mip4
    multimob netext ntp pcp pppext savi shim6 softwire tictoc trill
    adslmib armd bmwg dime dnsop eman grow ipfix mboned netconf netmod
    opsawg opsec pmol radext v6ops atoca avtcore avtext bliss clue codec
    cuss dispatch drinks ecrit enum geopriv mediactrl mmusic p2psip
    payload salud simple sipclf sipcore siprec soc speechsc speermint
    splices vipr xcon xmpp xrblock bfd ccamp forces idr isis karp l2vpn
    l3vpn manet mpls ospf pce pim pwe3 roll rtgwg sidr vrrp abfab dane
    dkim emu hokey ipsecme isms kitten krb ltans msec nea oauth pkix
    tls alto behave conex dccp decade fecframe ippm ledbat mptcp nfsv4
    pcn ppsp rmt storm tcpm tsvwg
  ]

  @@concluded = %w[
    822ext acap apex applmib asid atompub beep calsch calsify chronos
    cdi conneg crisp dasl drums edi ediint fax find ftpext html http
    idnabis ids imap imapext impp ipp ldapbis ldapext ldup lemonade
    list lsma ltru madman marid mailext mhsds mhtml mimemhs mimesgml
    mixer morg msgtrk netdata netfax nntp nntpext notary npp oda opes
    osids pop prim provreg printmib quis receipt rescap schema smtpext
    tn3270e telnet tftpexts tip trade urc uri urlreg urn usefor vpim
    webdav webi whip widex wrec x400ops xmpp icar ipr newtrk nomcom
    poised poised95 poisson problem 16ng addrconf ale appleip catnip
    cip dna dns dnsind eap fddi frnetmib hostreq idn ifmib ion ip1394
    ipae ipatm ipfc iplpdn ipoib iporpr ippcp ipngwg ipv6 ipv6mib ipvbi
    isdnmib itrace magma mip6 mipshop mmb mobileip monami6 mpsnmp mptrans
    mtudisc nemo netlmm pana pcc pip pktway ppp rdisc send shr smds st2
    svrloc tpix trunkmib tuba vgmib zeroconf sipp acct alertman charmib
    chassis decnetiv ethermib fddimib hostmib lanman modemmgt msi oim
    rdbmsmib snmp snmpauth snmpv2 transmib trmon x25mib acct2 bgpdepl
    cidrd eii gisd ire netstat newdom njm noop opstat ucp 2000 aaa
    agentx atommib bridge capwap disman entmib eos 6bone grip hubmib
    imss ipcdn lsd multi6 nasreq ngtrans pier policy psamp ptomaine
    ptopomib radius rap rmonmib roamops rps rwhois sming snmpconf snmpv3
    upsmib osigen osinsap osix400 skinstak thinosi avt ieprep iptel
    martini megaco sigtran sip sipping bgp bgmp dlswmib idmr idpr ipidrp
    l1vpn msdp nimrod odv pdnrout qosr rip ripv2 rolc rpsec rreq sdr
    snadlc snanau ssm udlr aac aft btns cat cipso dnssec enroll ident
    idwgr inch ipauth ipsec ipseckey ipsp ipsra ispp keyprov kink mobike
    openpgp otp pem pki4ipsec sacred sasl secsh smime snmpsec spki spwg
    stime syslog tnfs xmldsig wts gsmp ipo ppvpn tewg diffserv ecm imm
    intserv issll ips midcom nat nsis oncrpc malloc pilc pint pmtud
    rddp rohc rserpool rsvp rtfm seamoby spirits tcpimpl tcplw tcpsat
    arts disi fyiup harts iafa iiir isn iup nir nisi noctool2 noctools
    run ssh stdguide trainmat userdoc userdoc2 userglos weird wnils
    uswg
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