module IRTF

  class Person
    attr_reader :first, :last, :email, :web, :fb
    
    def initialize(first, last, email, web, fb)
      @first = first  # first name
      @last = last    # last name
      @email = email  # email address
      @web = web      # web page
      @fb = fb        # Facebook ID
    end
    
    def <=>(other)
      @last <=> other.last or @first <=> other.first
    end
    
    def name
      "#{first} #{last}"
    end
    
    def hamlify()
      # XXX can we return HAML here instead of HTML?
      if web then
        result = link_to(name, web)
      else
        result = name
      end
      if email then
        result += " (" + link_to(email.downcase, "mailto:#{email.downcase}") +
                  ")"
      end
      return result
    end
  end

  class RG
    attr_reader :acronym, :name, :list, :listweb, :web, :chairs
  
    def initialize(acronym, name, list, listweb, web, chairs)
      @acronym = acronym.upcase
      @name = name + " Research Group"
      @list = list
      # handle IRTF lists by default
      if list =~ /irtf.org$/ then
        @listweb = "/mailman/listinfo/" + list.split("@").first.downcase
      else
        @listweb = listweb.downcase
      end
      @web = web
      @chairs = chairs
    end

    def <=>(other)
      @acronym <=> other.acronym
    end
    
    def url(loc = "")
      link_to(acronym, loc + acronym.downcase, :title => name)
    end
  end

  # ASRG
  levine = Person.new("John", "Levine", "johnl@iecc.com", "http://johnlevine.com/", nil)
  asrg = RG.new(
    "asrg",
    "Anti-Spam",
    "asrg@irtf.org",
    nil,
    "http://asrg.sp.am/",
    [ levine ]
  )

  # CFRG
  # canetti = Person.new("Ran", "Canetti", "canetti@watson.ibm.com")
  mcgrew = Person.new("David", "McGrew", "mcgrew@cisco.com", "http://mindspring.com/~dmcgrew/dam.htm", nil)
  igoe = Person.new("Kevin", "Igoe", "kmigoe@nsa.gov", nil, nil)
  cfrg = RG.new(
    "cfrg",
    "Crypto Forum",
    "cfrg@irtf.org",
    nil,
    nil, # retired "rg/cfrg/", there is nothing there that is not on the charter
    [ mcgrew, igoe ]
  )

  # DTNRG
  fall = Person.new("Kevin", "Fall", nil, "http://cs.berkeley.edu/~kfall", nil)
  farrell = Person.new("Stephen", "Farrell", nil, "http://cs.tcd.ie/Stephen.Farrell/", nil)
  ott = Person.new("J&ouml;rg", "Ott", "jo@netlab.tkk.fi", "http://www.netlab.tkk.fi/~jo/", nil) # www is needed
  dtnrg = RG.new(
    "dtnrg",
    "Delay-Tolerant Networking",
    "dtn-interest@irtf.org",
    nil,
    "http://dtnrg.org/",
    [ fall, farrell, ott ]
  )

  # HIPRG
  gurtov = Person.new("Andrei", "Gurtov", "gurtov@cs.helsinki.fi", "http://cs.helsinki.fi/u/gurtov/", nil)
  henderson = Person.new("Tom", "Henderson", "thomas.r.henderson@boeing.com", "http://tomh.org/", nil)
  hiprg = RG.new(
    "hiprg",
    "Host Identity Protocol",
    "hiprg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/hiprg",
    [ gurtov, henderson ]
  )

  # ICCRG
  welzl = Person.new("Michael", "Welzl", "michawe@ifi.uio.no", "http://heim.ifi.uio.no/michawe/", nil)
  sridharan = Person.new("Murari", "Sridharan", "muraris@microsoft.com", "http://linkedin.com/pub/murari-sridharan/5/a38/153", "1602611111")
  iccrg = RG.new(
    "iccrg",
    "Internet Congestion Control",
    "iccrg@cs.ucl.ac.uk",
    "http://oakham.cs.ucl.ac.uk/mailman/listinfo/iccrg",
    "http://tools.ietf.org/group/irtf/trac/wiki/ICCRG",
    [ welzl, sridharan ]
  )

  # MOBOPTS
  koodli = Person.new("Rajeev", "Koodli", "rkoodli@cisco.com", "http://linkedin.com/in/rajeevkoodli", nil)
  krishnan = Person.new("Suresh", "Krishnan", "suresh.krishnan@ericsson.com", nil, nil)
  mobopts = RG.new(
    "mobopts",
    "IP Mobility Optimizations",
    "mobopts@irtf.org",
    nil,
    nil,
    [ koodli, krishnan ]
  )

  # NCRG
  behringer = Person.new("Michael", "Behringer", "mbehring@cisco.com", "http://linkedin.com/in/mbehringer", nil)
  huston = Person.new("Geoff", "Huston", "gih@apnic.net", "http://potaroo.net/", nil)
  ncrg = RG.new(
    "ncrg",
    "Network Complexity",
    "ncrg@irtf.org",
    nil,
    "http://networkcomplexity.org/",
    [ behringer, huston ]
  )

  # NMRG
  granville = Person.new("Lisandro", "Granville", "granville@inf.ufrgs.br", "http://inf.ufrgs.br/~granville/", nil)
  festor = Person.new("Olivier", "Festor", "Olivier.Festor@inria.fr", "http://www.loria.fr/~festor/Site/Welcome.html", nil) # www is needed
  nmrg = RG.new(
    "nmrg",
    "Network Management",
    "nmrg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/NetworkManagementResearchGroup",
    [ granville, festor ]
  )

  # P2PRG
  hiltl = Person.new("Volker", "Hilt", "volkerh@bell-labs.com", nil, nil)
  previdi = Person.new("Stefano", "Previdi", "sprevidi@cisco.com", "http://linkedin.com/in/sprevidi", nil)
  p2prg = RG.new(
    "p2prg",
    "Peer-to-Peer",
    "p2prg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/PeerToPeerResearchGroup",
    [ hiltl, previdi ]
  )

  # RRG
  # zhang = Person.new("Lixia", "Zhang", "lixia@CS.UCLA.EDU")
  li = Person.new("Tony", "Li", "tony.li@tony.li", "http://linkedin.com/pub/tony-li/0/130/2a9", nil)
  rrg = RG.new(
    "rrg",
    "Routing",
    "rrg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/RoutingResearchGroup",
    [ li ]
  )

  # SAMRG
  buford = Person.new("John", "Buford", "buford@samrg.org", "http://samrg.org/buford/index.html", nil)
  schmidt = Person.new("Thomas", "Schmidt", "schmidt@informatik.haw-hamburg.de", "http://users.informatik.haw-hamburg.de/~schmidt/", nil)
  samrg = RG.new(
    "samrg",
    "Scalable Adaptive Multicast",
    "sam@irtf.org",
    nil,
    "http://samrg.org/",
    [ buford, schmidt ]
  )

  # VNRG
  touch = Person.new("Joe", "Touch", "touch@isi.edu", "http://isi.edu/touch/", nil)
  stiemerling = Person.new("Martin", "Stiemerling", "stiemerling@nw.neclab.eu", "http://ietf.stiemerling.org/", nil)
  vnrg = RG.new(
    "vnrg",
    "Virtual Networks",
    "vnrg@irtf.org",
    nil,
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/vnrg",
    [ touch, stiemerling ]
  )

  # RG list
  $rgs = {
    "cfrg"    => cfrg,
    "asrg"    => asrg,
    "dtnrg"   => dtnrg,
    "hiprg"   => hiprg,
    "iccrg"   => iccrg,
    "mobopts" => mobopts,
    "ncrg"    => ncrg,
    "nmrg"    => nmrg,
    "p2prg"   => p2prg,
    "rrg"     => rrg,
    "samrg"   => samrg,
    "vnrg"    => vnrg
  }
  
  # ls concluded/irtf.org/charter\?gtype=old-rg\&group=* | cut -f3 -d=
  $oldrgs = {
    "aaaarch" => "AAA Architecture", # Authentication Authorisation Accounting
    "buds"    => "Building Differentiated Services",
    "eme"     => "End Middle End",
    "end2end" => "End-to-End",
    "gsec"    => "Group Security",
    "idrm"    => "Internet Digital Rights Management",
    "iiarg"   => "Information Infrastructure Architecture",
    "imrg"    => "Internet Measurement",
    "ipnrg"   => "Interplanetary Internet",
    "ird"     => "Internet Resource Discovery",
    "nsrg"    => "Namespace",
    "pkng"    => "Public Key Next-Generation",
    "psrg"    => "Privacy and Security",
    "rmrg"    => "Reliable Multicast",
    "siren"   => "Searchable Internet Resource Names",
    "smrg"    => "Services Management",
    "tmrg"    => "Transport Modeling"
  }
  $oldrgs.keys.each do |n|
    $oldrgs[n] += " Research Group"
  end
  
  # RG pattern
  $rgpat = Regexp.new('\b(' + $rgs.keys.compact.join("|") + ')\b', true);

  # IRSG
  eggert = Person.new("Lars", "Eggert", "irtf-chair@irtf.org", "http://eggert.org/", "584143839")
  $chair = eggert
  falk = Person.new("Aaron", "Falk", "falk@bbn.com", "http://linkedin.com/in/aaronfalk", nil)
  allman = Person.new("Mark", "Allman", "mallman@icir.org", "http://www.icir.org/mallman/", nil)
  dawkins = Person.new("Spencer", "Dawkins", "spencer@wonderhamster.org", "http://linkedin.com/in/spencerdawkins", nil)
  $atlarge = [ falk, allman, dawkins ]
  
  # lookahead pattern for filter regexps to make sure we don't replace in links or headings
  $boundary = "(?![^<'\"]*?(?:(?:<\/(?:a|h2|h3|span|dt)>))|['\"])"
  
end