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
    attr_reader :acronym, :name, :list, :listweb, :web, :chairs, :secretaries, :chartered, :concluded

    def initialize(acronym, name, list, listweb, web, chairs, secretaries, chartered, concluded)
      @acronym = acronym.upcase
      @name = name + " Research Group"
      @list = list
      # handle IRTF lists by default
      if list =~ /irtf.org$/ then
        if concluded then
          @listweb = "https://www.ietf.org/mail-archive/web/" + list.split("@").first.downcase
        else
          @listweb = "/mailman/listinfo/" + list.split("@").first.downcase
        end
      else
        @listweb = listweb.downcase
      end
      @web = web
      @chairs = chairs
      @secretaries = secretaries
      @chartered = chartered
      @concluded = concluded
    end

    def <=>(other)
      @acronym <=> other.acronym
    end

    def url(loc = "")
      link_to(acronym, loc + acronym.downcase, :title => name)
    end

    def contacts
      result = @acronym.downcase + "\n" +
             "    Research Group Name:\n" +
             "        " + @name + "\n" +
             "    Chair(s):\n"
      @chairs.each {|c|
        result += "        " + c.first + " " + c.last + " <" + c.email + ">\n"
      }
      result += "    List:\n" +
                "        " + @list
    return result
    end
  end

  # ASRG
  levine = Person.new("John", "Levine", "johnl@iecc.com", "https://johnlevine.com/", nil)
  asrg = RG.new(
    "asrg",
    "Anti-Spam",
    "asrg@irtf.org",
    nil,
    "https://asrg.sp.am/",
    [ levine ],
    nil,
    nil,
    "2013-3-18"
  )

  # CFRG
  # canetti = Person.new("Ran", "Canetti", "canetti@watson.ibm.com")
  # mcgrew = Person.new("David", "McGrew", "mcgrew@cisco.com", "https://mindspring.com/~dmcgrew/dam.htm", nil)
  # igoe = Person.new("Kevin", "Igoe", "kmigoe@nsa.gov", nil, nil)
  paterson = Person.new("Kenny", "Paterson", "kenny.paterson@rhul.ac.uk", "https://www.isg.rhul.ac.uk/~kp/", nil)
  melnikov = Person.new("Alexey", "Melnikov", "alexey.melnikov@isode.com", "https://www.melnikov.ca", nil)

  cfrg = RG.new(
    "cfrg",
    "Crypto Forum",
    "cfrg@irtf.org",
    nil,
    nil, # retired "rg/cfrg/", there is nothing there that is not on the charter
    [ paterson, melnikov ],
    nil,
    nil,
    nil
  )

  # DTNRG
  fall = Person.new("Kevin", "Fall", "kfall@acm.org", "https://kfall.net/ucbpage/", nil)
  ott = Person.new("Jörg", "Ott", "jo@netlab.tkk.fi", "https://www.netlab.tkk.fi/~jo/", nil) # www is needed
  dtnrg = RG.new(
    "dtnrg",
    "Delay-Tolerant Networking",
    "dtn-interest@irtf.org",
    nil,
    "https://sites.google.com/site/dtnresgroup/",
    [ fall, ott ],
    nil,
    nil,
    "2016-4-5"
  )

  # GAIA
  sathiaseelan = Person.new("Arjuna", "Sathiaseelan", "arjuna.sathiaseelan@cl.cam.ac.uk", "https://www.cl.cam.ac.uk/~as2330/", nil)
  ford = Person.new("Mat", "Ford", "ford@isoc.org", "https://www.internetsociety.org/who-we-are/people/mr-mat-ford", nil)
  gaia = RG.new(
    "gaia",
    "Global Access to the Internet for All",
    "gaia@irtf.org",
    nil,
    "https://sites.google.com/site/irtfgaia/",
    [ sathiaseelan, ford ],
    nil,
    "2014-10-15",
    nil
  )

  # HIPRG
  gurtov = Person.new("Andrei", "Gurtov", "gurtov@cs.helsinki.fi", "https://www.cs.helsinki.fi/u/gurtov/", nil)
  henderson = Person.new("Tom", "Henderson", "thomas.r.henderson@boeing.com", "https://tomh.org/", nil)
  hiprg = RG.new(
    "hiprg",
    "Host Identity Protocol",
    "hiprg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/hiprg",
    [ gurtov, henderson ],
    nil,
    nil,
    "2012-7-24"
  )

  # HRPC
  tenoever = Person.new("Niels", "ten Oever", "niels@article19.org", "https://nielstenoever.net/", nil)
  doria = Person.new("Avri", "Doria", "avri@acm.org", "https://www.linkedin.com/in/doriavr", nil)
  hrpc = RG.new(
    "hrpc",
    "Human Rights Protocol Considerations",
    "hrpc@irtf.org",
    nil,
    "https://hrpc.io/",
    [ tenoever, doria ],
    nil,
    "2015-11-30",
    nil
  )

  # ICCRG
  welzl = Person.new("Michael", "Welzl", "michawe@ifi.uio.no", "https://heim.ifi.uio.no/michawe/", 1515901207)
  iyengar = Person.new("Jana", "Iyengar", "jri@google.com", "https://www.linkedin.com/in/jana-iyengar-2121252", nil)
  # ros = Person.new("David", "Ros", "dros@simula.no", "https://simula.no/people/dros", nil)
  iccrg = RG.new(
    "iccrg",
    "Internet Congestion Control",
    "iccrg@irtf.org",
    nil,
    "https://tools.ietf.org/group/irtf/trac/wiki/ICCRG",
    [ welzl, iyengar ],
    nil,
    nil,
    nil
  )

  # ICNRG
  kutscher = Person.new("Dirk", "Kutscher", "Dirk.Kutscher@neclab.eu", "https://dirk-kutscher.info/", nil)
  ohlman = Person.new("Börje", "Ohlman", "borje.ohlman@ericsson.com", "https://linkedin.com/pub/b%3Frje-ohlman/0/270/283", nil)
  oran = Person.new("Dave", "Oran", "oran@cisco.com", "https://linkedin.com/pub/david-oran/0/b7/7b4", nil)
  icnrg = RG.new(
    "icnrg",
    "Information-Centric Networking",
    "icnrg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/icnrg",
    [ kutscher, ohlman, oran ],
    nil,
    "2012-4-17",
    nil
  )

  # maprg
  kuhlewind = Person.new("Mirja", "Kühlewind", "mirja.kuehlewind@tik.ee.ethz.ch", "http://www.csg.ethz.ch/people/mirjak", nil)
  plonka = Person.new("Dave", "Plonka", "dave@plonka.us", "http://pages.cs.wisc.edu/~plonka/", nil)
  maprg = RG.new(
    "maprg",
    "Measurement and Analysis for Protocols",
    "maprg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/map",
    [ kuhlewind, plonka ],
    nil,
    "2016-8-22",
    nil
  )

  # MOBOPTS
  koodli = Person.new("Rajeev", "Koodli", "rkoodli@cisco.com", "https://linkedin.com/in/rajeevkoodli", nil)
  krishnan = Person.new("Suresh", "Krishnan", "suresh.krishnan@ericsson.com", nil, nil)
  mobopts = RG.new(
    "mobopts",
    "IP Mobility Optimizations",
    "mobopts@irtf.org",
    nil,
    nil,
    [ koodli, krishnan ],
    nil,
    nil,
    "2012-6-8"
  )

  # NCRG
  behringer = Person.new("Michael", "Behringer", "mbehring@cisco.com", "https://linkedin.com/in/mbehringer", nil)
  # huston = Person.new("Geoff", "Huston", "gih@apnic.net", "https://potaroo.net/", nil)
  meyer = Person.new("David", "Meyer", "dmm@1-4-5.net", "https://www.1-4-5.net/~dmm/vita.html", nil)
  ncrg = RG.new(
    "ncrg",
    "Network Complexity",
    "ncrg@irtf.org",
    nil,
    "https://networkcomplexity.org/",
    [ behringer, meyer ],
    nil,
    "2011-10-4",
    "2014-6-13"
  )

  # NFVRG
  lopez = Person.new("Diego", "Lopez", "diego.r.lopez@telefonica.com", "https://people.tid.es/diego.lopez/", nil)
  ramki = Person.new("Ramki", "Krishnan", "Ramki_Krishnan@Dell.com", "https://linkedin.com/pub/ram-krishnan/0/a10/2ba", nil)
  krishnaswamy = Person.new("Dilip", "Krishnaswamy", "dilip@ieee.org", "https://sites.google.com/site/dilip1/home", nil)
  nfvrg = RG.new(
    "nfvrg",
    "Network Function Virtualization",
    "nfvrg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/nfvrg",
    [ lopez, ramki ],
    [ krishnaswamy ],
    "2015-1-20",
    nil
  )

  # NWCRG
  adamson = Person.new("Brian", "Adamson", "brian.adamson@nrl.navy.mil", "https://linkedin.com/in/brianadamson", nil)
  firoiu = Person.new("Victor", "Firoiu", "vfiroiu@acm.org", "https://victor.firoiu.org/", nil)
  nwcrg = RG.new(
    "nwcrg",
    "Network Coding",
    "nwcrg@irtf.org",
    nil,
    nil,
    [ adamson, firoiu ],
    nil,
    "2013-11-13",
    nil
  )

  # NMRG
  granville = Person.new("Lisandro", "Granville", "granville@inf.ufrgs.br", "https://inf.ufrgs.br/~granville/", nil)
  # festor = Person.new("Olivier", "Festor", "Olivier.Festor@inria.fr", "https://www.loria.fr/~festor/Site/Welcome.html", nil) # www is needed
  ciavaglia = Person.new("Laurent", "Ciavaglia", "Laurent.Ciavaglia@alcatel-lucent.com", "https://www.linkedin.com/in/laurentciavaglia", nil)
  nmrg = RG.new(
    "nmrg",
    "Network Management",
    "nmrg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/NetworkManagementResearchGroup",
    [ granville, ciavaglia ],
    nil,
    nil,
    nil
  )

  # P2PRG
  hiltl = Person.new("Volker", "Hilt", "volkerh@bell-labs.com", nil, nil)
  previdi = Person.new("Stefano", "Previdi", "sprevidi@cisco.com", "https://linkedin.com/in/sprevidi", nil)
  p2prg = RG.new(
    "p2prg",
    "Peer-to-Peer",
    "p2prg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/PeerToPeerResearchGroup",
    [ hiltl, previdi ],
    nil,
    nil,
    "2013-2-25"
  )

  # RRG
  # zhang = Person.new("Lixia", "Zhang", "lixia@CS.UCLA.EDU")
  li = Person.new("Tony", "Li", "tony.li@tony.li", "https://linkedin.com/pub/tony-li/0/130/2a9", nil)
  rrg = RG.new(
    "rrg",
    "Routing",
    "rrg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/RoutingResearchGroup",
    [ li ],
    nil,
    nil,
    "2014-6-10"
  )

  # SAMRG
  buford = Person.new("John", "Buford", "buford@samrg.org", "https://samrg.org/buford/index.html", nil)
  schmidt = Person.new("Thomas", "Schmidt", "schmidt@informatik.haw-hamburg.de", "https://users.informatik.haw-hamburg.de/~schmidt/", nil)
  samrg = RG.new(
    "samrg",
    "Scalable Adaptive Multicast",
    "sam@irtf.org",
    nil,
    "https://samrg.org/",
    [ buford, schmidt ],
    nil,
    nil,
    "2013-12-17"
  )

  # SDNRG
  king = Person.new("Daniel", "King", "d.king@lancaster.ac.uk", "https://www.research.lancs.ac.uk/portal/en/people/daniel-king", nil)
  shiomoto = Person.new("Kohei", "Shiomoto", "shiomoto.kohei@lab.ntt.co.jp", "https://jp.linkedin.com/pub/kohei-shiomoto/0/bb5/676", nil)

  sdnrg = RG.new(
    "sdnrg",
    "Software-Defined Networking",
    "sdn@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/sdnrg",
    [ king, shiomoto ],
    nil,
    "2013-1-14",
    nil
  )

  # TMRG
  andrew = Person.new("Lachlan", "Andrew", "lachlan.andrew@gmail.com", "https://caia.swin.edu.au/cv/landrew/", nil)
  tmrg = RG.new(
    "tmrg",
    "Transport Modeling",
    "tmrg@irtf.org",
    nil,
    "https://tools.ietf.org/group/irtf/trac/wiki/tmrg",
    [ andrew ],
    nil,
    nil,
    "2011-9-26"
  )

  # T2TRG
  bormann = Person.new("Carsten", "Bormann", "cabo@tzi.org", "https://www.informatik.uni-bremen.de/~cabo/", nil)
  keranen = Person.new("Ari", "Keränen", "ari.keranen@ericsson.com", "https://www.linkedin.com/in/akeranen", nil)
  t2trg = RG.new(
    "t2trg",
    "Thing-to-Thing",
    "t2trg@irtf.org",
    nil,
    "https://github.com/t2trg",
    [ bormann, keranen ],
    nil,
    "2015-12-2",
    nil
  )

  # VNRG
  touch = Person.new("Joe", "Touch", "touch@isi.edu", "https://isi.edu/touch/", nil)
  stiemerling = Person.new("Martin", "Stiemerling", "mls.ietf@gmail.com", "https://www.fbi.h-da.de/organisation/personen/stiemerling-martin/", nil)
  vnrg = RG.new(
    "vnrg",
    "Virtual Networks",
    "vnrg@irtf.org",
    nil,
    "https://trac.tools.ietf.org/group/irtf/trac/wiki/vnrg",
    [ touch, stiemerling ],
    nil,
    nil,
    "2012-2-8"
  )

  # Active RGs
  $rgs = {
    "cfrg"  => cfrg,
    "gaia" => gaia,
    "hrpc" => hrpc,
    "iccrg" => iccrg,
    "icnrg" => icnrg,
    "maprg" => maprg,
    "nfvrg" => nfvrg,
    "nmrg"  => nmrg,
    "nwcrg" => nwcrg,
    "sdnrg" => sdnrg,
    "t2trg" => t2trg
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
    "tmrg"    => "Transport Modeling",
  }

  $oldrgs.keys.each do |n|
    $oldrgs[n] += " Research Group"
  end

  # These RGs concluded since the web page redesign. They are rendered based on the data in this file.
  $oldrgs["tmrg"] = tmrg;
  $oldrgs["vnrg"] = vnrg;
  $oldrgs["mobopts"] = mobopts;
  $oldrgs["hiprg"] = hiprg;
  $oldrgs["p2prg"] = p2prg;
  $oldrgs["asrg"] = asrg;
  $oldrgs["samrg"] = samrg;
  $oldrgs["rrg"] = rrg;
  $oldrgs["ncrg"] = ncrg;
  $oldrgs["dtnrg"] = dtnrg;

  # RG pattern
  $rgpat = Regexp.new('\b(' + $rgs.keys.compact.join("|") + ')\b', true);

  # IRSG
  eggert = Person.new("Lars", "Eggert", "irtf-chair@irtf.org", "https://eggert.org/", "584143839")
  $chair = eggert
  falk = Person.new("Aaron", "Falk", "aaron.falk@gmail.com", "https://linkedin.com/in/aaronfalk", nil)
  allman = Person.new("Mark", "Allman", "mallman@icir.org", "https://www.icir.org/mallman/", nil)
  dawkins = Person.new("Spencer", "Dawkins", "spencerdawkins.ietf@gmail.com", "https://linkedin.com/in/spencerdawkins", nil)
  # arkko = Person.new("Jari", "Arkko", "jari.arkko@piuha.net", "https://www.arkko.com/", nil)
  # li = Person.new("Xing", "Li", "xing@cernet.edu.cn", "https://www.net-glyph.org/lixing/", nil)
  # lear = Person.new("Eliot", "Lear", "lear@cisco.com", "https://linkedin.com/pub/eliot-lear/0/81/b0a", nil)
  housley = Person.new("Russ", "Housley", "housley@vigilsec.com", "https://linkedin.com/pub/russ-housley/0/69/419", nil)
  farrell = Person.new("Stephen", "Farrell", "stephen.farrell@cs.tcd.ie", "https://cs.tcd.ie/Stephen.Farrell/", nil)
  droms = Person.new("Ralph", "Droms", "rdroms.ietf@gmail.com", "https://www.linkedin.com/pub/ralph-droms/0/493/a10", nil)
  nordmark = Person.new("Erik", "Nordmark", "nordmark@sonic.net", "https://www.linkedin.com/pub/erik-nordmark/10/243/771", nil)
  feamster = Person.new("Nick", "Feamster", "feamster@cs.princeton.edu", "https://www.cs.princeton.edu/~feamster/", nil)
  teixeira = Person.new("Renata", "Cruz Teixeira", "renata.teixeira@inria.fr", "https://who.rocq.inria.fr/Renata.Teixeira/", nil)
  $atlarge = [ falk, allman, dawkins, housley, farrell, droms, nordmark, feamster, teixeira ]

  def atlarge_contacts
    result = "irsg\n" +
           "    Research Group Name:\n" +
           "        Non-RG Chair IRSG members\n" +
           "    Chair(s):\n" +
           "        " + $chair.first + " " + $chair.last + " <" + $chair.email + ">\n" +
           "    Members:\n"
    $atlarge.each {|c|
      result += "        " + c.first + " " + c.last + " <" + c.email + ">\n"
    }
    result += "    List:\n" +
              "        irsg@irtf.org"
    return result
  end

end
