module IRTF

  class Person
    attr_reader :first, :last, :email, :web
    
    def initialize(first, last, email, web="")
      @first = first
      @last = last
      @email = email
      @web = web
    end
    
    def <=>(other)
      @last <=> other.last or @first <=> other.first
    end
    
    def name
      "#{first} #{last}"
    end
    
    def hamlify()
      # XXX can we return HAML here instead of HTML?
      if web.empty? then
        result = name
      else
        result = "<a href='#{web}'>#{name}</a>"
      end
      if not email.empty? then
        result += " (<a href='mailto:#{email.downcase}'>#{email.downcase}</a>)"
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
        @listweb = "mailman/listinfo/#{acronym.downcase}"
      else
        @listweb = listweb.downcase
      end
      @web = web
      @chairs = chairs
    end

    def <=>(other)
      @acronym <=> other.acronym
    end
    
    def url
#      "<a href='#{acronym.downcase}', title='#{name}'>#{acronym}</a>"
      "<a href='#{acronym.downcase}'>#{acronym}</a>"
    end
  end

  # ASRG
  levine = Person.new("John", "Levine", "johnl@iecc.com")
  asrg = RG.new(
    "asrg",
    "Anti-Spam",
    "asrg@irtf.org",
    "",
    "http://asrg.sp.am/",
    [ levine ]
  )

  # CFRG
  canetti = Person.new("Ran", "Canetti", "canetti@watson.ibm.com")
  mcgrew = Person.new("David", "McGrew", "mcgrew@cisco.com")
  cfrg = RG.new(
    "cfrg",
    "Crypto Forum",
    "cfrg@irtf.org",
    "",
    "", # retired "rg/cfrg/", there is nothing there that is not on the charter
    [ canetti, mcgrew ]
  )

  # DTNRG
  fall = Person.new("Kevin", "Fall", "", "http://www.cs.berkeley.edu/~kfall")
  farrell = Person.new("Stephen", "Farrell", "", "http://www.cs.tcd.ie/Stephen.Farrell/")
  ott = Person.new("J&ouml;rg", "Ott", "jo@netlab.tkk.fi")
  dtnrg = RG.new(
    "dtnrg",
    "Delay-Tolerant Networking",
    "dtn-interest@irtforg",
    "",
    "http://www.dtnrg.org/",
    [ fall, farrell, ott ]
  )

  # HIPRG
  gurtov = Person.new("Andrei", "Gurtov", "gurtov@cs.helsinki.fi")
  henderson = Person.new("Tom", "Henderson", "thomas.r.henderson@boeing.com")
  hiprg = RG.new(
    "hiprg",
    "Host Identity Protocol",
    "hiprg@irtf.org",
    "",
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/hiprg",
    [ gurtov, henderson ]
  )

  # ICCRG
  welzl = Person.new("Michael", "Welzl", "michawe@ifi.uio.no")
  sridharan = Person.new("Murari", "Sridharan", "muraris@microsoft.com")
  iccrg = RG.new(
    "iccrg",
    "Internet Congestion Control",
    "iccrg@cs.ucl.ac.uk",
    "http://oakham.cs.ucl.ac.uk/mailman/listinfo/iccrg",
    "http://www.tools.ietf.org/group/irtf/trac/wiki/ICCRG",
    [ welzl, sridharan ]
  )

  # MOBOPTS
  koodli = Person.new("Rajeev", "Koodli", "rkoodli@cisco.com")
  mobopts = RG.new(
    "mobopts",
    "IP Mobility Optimizations",
    "mobopts@irtf.org",
    "",
    "",
    [ koodli ]
  )

  # NMRG
  granville = Person.new("Lisandro", "Granville", "granville@inf.ufrgs.br")
  festor = Person.new("Olivier", "Festor", "Olivier.Festor@inria.fr")
  nmrg = RG.new(
    "nmrg",
    "Network Management",
    "nmrg@irtf.org",
    "",
    "http://www.ibr.cs.tu-bs.de/projects/nmrg/",
    [ granville, festor ]
  )

  # P2PRG
  hiltl = Person.new("Volker", "Hiltl", "volkerh@bell-labs.com")
  previdi = Person.new("Stefano", "Previdi", "sprevidi@cisco.com")
  p2prg = RG.new(
    "p2prg",
    "Peer-to-Peer",
    "p2prg@irtf.org",
    "",
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/PeerToPeerResearchGroup",
    [ hiltl, previdi ]
  )

  # RRG
  # zhang = Person.new("Lixia", "Zhang", "lixia@CS.UCLA.EDU")
  li = Person.new("Tony", "Li", "tony.li@tony.li")
  rrg = RG.new(
    "rrg",
    "Routing",
    "rrg@irtf.org",
    "",
    "http://trac.tools.ietf.org/group/irtf/trac/wiki/RoutingResearchGroup",
    [ li ]
  )

  # SAMRG
  buford = Person.new("John", "Buford", "buford@samrg.org")
  schmidt = Person.new("Thomas", "Schmidt", "schmidt@informatik.haw-hamburg.de")
  samrg = RG.new(
    "samrg",
    "Scalable Adaptive Multicast",
    "samrg@irtf.org",
    "",
    "http://www.samrg.org/",
    [ buford, schmidt ]
  )

  # TMRG
  andrew = Person.new("Lachlan", "Andrew", "lachlan.andrew@gmail.com")
  tmrg = RG.new(
    "tmrg",
    "Transport Modeling",
    "tmrg@irtf.org",
    "",
    "http://www.tools.ietf.org/group/irtf/trac/wiki/tmrg",
    [ andrew ]
  )

  # VNRG
  touch = Person.new("Joe", "Touch", "touch@isi.edu")
  stiemerling = Person.new("Martin", "Stiemerling", "stiemerling@nw.neclab.eu")
  vnrg = RG.new(
    "vnrg",
    "Virtual Networks",
    "vnrg@irtf.org",
    "",
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
    "nmrg"    => nmrg,
    "p2prg"   => p2prg,
    "rrg"     => rrg,
    "samrg"   => samrg,
    "tmrg"    => tmrg,
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
    "smrg"    => "Services Management"
  }
  $oldrgs.keys.each do |n|
    $oldrgs[n] += " Research Group"
  end
  
  # RG pattern
  $rgpat = Regexp.new('\b(' + $rgs.keys.join("|") + ')\b', true);

  # IRSG
  $eggert = Person.new("Lars", "Eggert", "irtf-chair@irtf.org")
  falk = Person.new("Aaron", "Falk", "falk@bbn.com")
  $atlarge = [ falk ]
  
  # boundary pattern for filters
  $boundary = '([ .,;:\(\)/])'
  
end