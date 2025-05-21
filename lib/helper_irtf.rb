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
#      if email then
#        result += " (" + link_to(email.downcase, "mailto:#{email.downcase}") +
#                  ")"
#      end
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
          @listweb = "https://mailman.irtf.org/mailman/listinfo/" + list.split("@").first.downcase
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
      link_to(acronym, loc + acronym.downcase + ".html", :title => name)
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
  #paterson = Person.new("Kenny", "Paterson", "kenny.paterson@rhul.ac.uk", "http://appliedcrypto.ethz.ch/people/kenny-paterson.html", nil)
  stanislav = Person.new("Stanislav", "Smyshlyaev",  "smyshsv@gmail.com>", "https://ru.linkedin.com/in/stanislav-smyshlyaev-62169333", nil)
  melnikov = Person.new("Alexey", "Melnikov", "alexey.melnikov@isode.com", nil, nil)
  sullivan = Person.new("Nick", "Sullivan", "nick@cloudflare.com", "https://crypto.dance/about", nil)

  cfrg = RG.new(
    "cfrg",
    "Crypto Forum",
    "cfrg@irtf.org",
    nil,
    nil, # retired "rg/cfrg/", there is nothing there that is not on the charter
    [ melnikov, sullivan, stanislav ],
    nil,
    "2014-11-13",
    nil
  )

#  COINRG
  he = Person.new("Jeffrey", "He", "jefhe@foxmail.com", nil, nil)
  montpetit = Person.new("Marie-José", "Montpetit", "marie@mjmontpetit.com", nil, nil)
  schooler = Person.new("Eve", "Schooler", "eve.m.schooler@intel.com", "http://eveschooler.com", nil)
  coinrg = RG.new(
    "coinrg",
    "Computation in the Network",
    "coin@irtf.org",
    nil,
    nil,
    [ montpetit, he, schooler ],
    nil,
    "2019-02-15",
    nil
  )

  # DINRG
  kutscher = Person.new("Dirk", "Kutscher", "ietf@dkutscher.net", "http://dirk-kutscher.info/", nil)
  zhang = Person.new("Lixia", "Zhang", "lixia@CS.UCLA.EDU", "https://web.cs.ucla.edu/~lixia/", nil)
  dinrg = RG.new(
    "dinrg",
    "Decentralization of the Internet",
    "din@irtf.org",
    nil,
    nil,
    [ kutscher, zhang ],
    nil,
    "2017-09-21",
    nil
  )

  # DTNRG
  fall = Person.new("Kevin", "Fall", "kfall@acm.org", "https://kfall.net/", nil)
  ott = Person.new("Jörg", "Ott", "ott@in.tum.de", "https://www.ce.cit.tum.de/en/cm/research-group/joerg-ott/", nil)
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
  # navarro = Person.new("Leandro", "Navarro", "leandro@ac.upc.edu", "http://people.ac.upc.edu/leandro/", nil)
  # sathiaseelan = Person.new("Arjuna", "Sathiaseelan", "arjuna.sathiaseelan@cl.cam.ac.uk", "https://www.cl.cam.ac.uk/~as2330/", nil)
  coffin = Person.new("Jane", "Coffin", "coffin@isoc.org", "https://www.internetsociety.org/who-we-are/people/jane-coffin", nil)
  heimerl  = Person.new("Kurtis", "Heimerl", "kheimerl@cs.washington.edu", "https://kurti.sh", nil)
  gaia = RG.new(
    "gaia",
    "Global Access to the Internet for All",
    "gaia@irtf.org",
    nil,
    "https://sites.google.com/site/irtfgaia/",
    [ coffin, heimerl ],
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
    "https://wiki.ietf.org/group/hiprg",
    [ gurtov, henderson ],
    nil,
    nil,
    "2012-7-24"
  )

  # HRPC
  tenoever = Person.new("Niels", "ten Oever", "niels@article19.org", "https://nielstenoever.net/", nil)
  knodel = Person.new("Mallory", "Knodel", "mallory@article19.org", "https://www.linkedin.com/in/malloryknodel/", nil)
  doria = Person.new("Avri", "Doria", "avri@acm.org", "https://www.linkedin.com/in/doriavr", nil)
  celi  = Person.new("Sofía", "Celi", "cherenkov@riseup.net", "https://www.sofiaceli.com", nil)
  hrpc = RG.new(
    "hrpc",
    "Human Rights Protocol Considerations",
    "hrpc@irtf.org",
    nil,
    "https://hrpc.io/",
    [ knodel, celi ],
    nil,
    "2015-11-30",
    nil
  )

  # ICCRG
  ferlin = Person.new("Simone", "Ferlin", "simoneferlin@gmail.com", "https://ferlin.io", nil)
  enghardt = Person.new("Reese", "Enghardt", "ietf@tenghardt.net", "https://tenghardt.net", nil)
  goel = Person.new("Vidhi", "Goel", "vidhi_goel@apple.com", "https://datatracker.ietf.org/person/vidhi_goel@apple.com", nil)
  # schapira = Person.new("Michael", "Schapira", "schapiram@huji.ac.il", "https://www.michaelschapira.com", nil)
  # ros = Person.new("David", "Ros", "dros@simula.no", "https://simula.no/people/dros", nil)
  iccrg = RG.new(
    "iccrg",
    "Internet Congestion Control",
    "iccrg@irtf.org",
    nil,
    "https://wiki.ietf.org/group/iccrg",
    [ ferlin, enghardt, goel ],
    nil,
    "2014-11-13",
    nil
  )

  # ICNRG
  ohlman = Person.new("Börje", "Ohlman", "borje.ohlman@ericsson.com", nil, nil)
  oran = Person.new("Dave", "Oran", "daveoran@orandom.net", "https://linkedin.com/pub/david-oran/0/b7/7b4", nil)
  icnrg = RG.new(
    "icnrg",
    "Information-Centric Networking",
    "icnrg@irtf.org",
    nil,
    "https://wiki.ietf.org/group/icnrg",
    [ kutscher, oran ],
    nil,
    "2012-04-17",
    nil
  )

  # maprg
  kuhlewind = Person.new("Mirja", "Kühlewind", "mirja.kuehlewind@tik.ee.ethz.ch", "http://mirja.kuehlewind.net", nil)
  plonka = Person.new("Dave", "Plonka", "dave@plonka.us", "http://pages.cs.wisc.edu/~plonka/", nil)
  maprg = RG.new(
    "maprg",
    "Measurement and Analysis for Protocols",
    "maprg@irtf.org",
    nil,
    "https://wiki.ietf.org/group/maprg",
    [ kuhlewind, plonka ],
    nil,
    "2016-08-22",
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
    "2012-06-08"
  )

  # NCRG
  behringer = Person.new("Michael", "Behringer", "mbehring@cisco.com", "https://linkedin.com/in/mbehringer", nil)
  # huston = Person.new("Geoff", "Huston", "gih@apnic.net", "https://potaroo.net/", nil)
  meyer = Person.new("David", "Meyer", "dmm@1-4-5.net", nil, nil)
  ncrg = RG.new(
    "ncrg",
    "Network Complexity",
    "ncrg@irtf.org",
    nil,
    "http://networkcomplexity.org/",
    [ behringer, meyer ],
    nil,
    "2011-10-4",
    "2014-6-13"
  )

  # NFVRG
  lopez = Person.new("Diego", "Lopez", "diego.r.lopez@telefonica.com", nil, nil)
  ramki = Person.new("Ramki", "Krishnan", "ramkri123@gmail.com", "https://linkedin.com/pub/ram-krishnan/0/a10/2ba", nil)
  # krishnaswamy = Person.new("Dilip", "Krishnaswamy", "dilip@ieee.org", "https://sites.google.com/site/dilip1/home", nil)
  banks = Person.new("Sarah", "Banks", "sbanks@encrypted.net", "https://www.linkedin.com/in/sbanks", nil)
  nfvrg = RG.new(
    "nfvrg",
    "Network Function Virtualization",
    "nfvrg@irtf.org",
    nil,
    "https://wiki..ietf.org/group/nfvrg",
    [ lopez, ramki ],
    [ banks ],
    "2015-01-20",
    "2018-08-01"
  )

  # NWCRG
  # adamson = Person.new("Brian", "Adamson", "brian.adamson@nrl.navy.mil", "https://linkedin.com/in/brianadamson", nil)
  # firoiu = Person.new("Victor", "Firoiu", "vfiroiu@acm.org", "https://victor.firoiu.org/", nil)
  roca = Person.new("Vincent", "Roca", "vincent.roca@inria.fr", "https://planete.inrialpes.fr/~roca/", nil)
  nwcrg = RG.new(
    "nwcrg",
    "NetWork Coding for Efficient Network Communications",
    "nwcrg@irtf.org",
    nil,
    nil,
    [ roca, montpetit ],
    nil,
    "2013-11-13",
    "2023-08-02"
  )

  # NMRG
  #granville = Person.new("Lisandro", "Granville", "granville@inf.ufrgs.br", "https://inf.ufrgs.br/~granville/", nil)
  # festor = Person.new("Olivier", "Festor", "Olivier.Festor@inria.fr", "https://www.loria.fr/~festor/Site/Welcome.html", nil) # www is needed
  ciavaglia = Person.new("Laurent", "Ciavaglia", "laurent.ciavaglia@nokia.com", "https://www.linkedin.com/in/laurentciavaglia", nil)
  francois = Person.new("Jérôme", "François", "jerome.francois@inria.fr", "http://jeromefra.free.fr", nil)
  nmrg = RG.new(
    "nmrg",
    "Network Management",
    "nmrg@irtf.org",
    nil,
    "https://wiki.ietf.org/group/nmrg",
    #   [ ciavaglia, francois ],
       [ francois ],
    nil,
    "1999-03-14",
    nil
  )

  # PANRG
  trammell = Person.new("Brian", "Trammell", "ietf@trammell.ch", "https://trammell.ch/", nil)
  linkova = Person.new("Jen", "Linkova", "furry13@gmail.com", "https://www.linkedin.com/in/furry", nil)
  panrg = RG.new(
    "panrg",
    "Path Aware Networking",
    "panrg@irtf.org",
    nil,
    nil,
    [ linkova, trammell ],
    nil,
    "2017-06-09",
    nil
  )

  # PEARG
  dickinson = Person.new("Sara", "Dickinson", "sara@sinodun.com", nil, nil)
  sahib = Person.new("Shivan", "Sahib", "ssahib@salesforce.com", "https://shivankaul.com/", nil)
  mankin = Person.new("Allison", "Mankin", "allison.mankin@gmail.com", "https://datatracker.ietf.org/person/Allison%20Mankin", nil)
  pearg = RG.new(
    "pearg",
    "Privacy Enhancements and Assessments",
    "pearg@irtf.org",
    nil,
    "https://pearg.org/",
    [ dickinson, sahib, mankin ],
    nil,
    "2018-00-19",
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
    "https://wiki.ietf.org/group/p2prg",
    [ hiltl, previdi ],
    nil,
    nil,
    "2013-02-25"
  )

  # QIRG
  vanmeter = Person.new("Rod", "van Meter", "rdviii@gmail.com", "https://web.sfc.keio.ac.jp/~rdv/", nil)
  wehner = Person.new("Stephanie", "Wehner", "S.D.C.Wehner@tudelft.nl", nil, nil)
  wojtek = Person.new("Wojciech", "Kozlowski", "W.Kozlowski@tudelft.nl", "https://wojciechkozlowski.eu", nil)
  qirg = RG.new(
    "qirg",
    "Quantum Internet",
    "qirg@irtf.org",
    nil,
    nil,
    [ vanmeter, wojtek ],
    nil,
    "2018-09-19",
    nil
  )

  # RASPRG
  castro = Person.new("Ignacio", "Castro", "i.castro@qmul.ac.uk", "https://datatracker.ietf.org/person/i.castro@qmul.ac.uk", nil)
  retana = Person.new("Alvaro", "Retana", "aretana.ietf@gmail.com", "https://datatracker.ietf.org/person/aretana.ietf@gmail.com", nil)
  rasprg = RG.new(
    "rasprg",
    "Research and Analysis of Standard-Setting Processes",
    "rasprg@irtf.org",
    nil,
    nil,
    [ castro, retana ],
    nil,
    "2023-02-21",
    nil
  )

  # RRG
  # zhang = Person.new("Lixia", "Zhang", "lixia@CS.UCLA.EDU")
  li = Person.new("Tony", "Li", "tony.li@tony.li", "https://linkedin.com/pub/tony-li/0/130/2a9", nil)
  rrg = RG.new(
    "rrg",
    "Routing",
    "rrg@irtf.org",
    nil,
    "https://wiki.ietf.org/group/rrg",
    [ li ],
    nil,
    nil,
    "2014-06-10"
  )

  # SAMRG
  buford = Person.new("John", "Buford", "buford@samrg.org", "https://samrg.org/buford/index.html", nil)
  schmidt = Person.new("Thomas", "Schmidt", "schmidt@informatik.haw-hamburg.de", "http://inet.haw-hamburg.de/members/schmidt", nil)
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
    "https://wiki.ietf.org/group/sdnrg",
    [ king, shiomoto ],
    nil,
    "2013-01-14",
    "2017-01-06"
  )

  rezaki = Person.new("Ali", "Rezaki", "ali.rezaki@nokia.com", "https://datatracker.ietf.org/person/ali.rezaki@nokia.com", nil)
  welzl = Person.new("Michael", "Welzl", "michawe@ifi.uio.no", "https://folk.universitetetioslo.no/michawe/", nil)

  sustain = RG.new(
    "sustain",
    "Sustainability and the Internet Proposed",
    "sustain@irtf.org",
    nil,
    nil,
    [ rezaki, schooler, welzl ],
    nil,
    "2025-01-17",
    nil
  )


  # TMRG
  andrew = Person.new("Lachlan", "Andrew", "lachlan.andrew@gmail.com", "http://caia.swin.edu.au/cv/landrew/", nil)
  tmrg = RG.new(
    "tmrg",
    "Transport Modeling",
    "tmrg@irtf.org",
    nil,
    "https://wiki.ietf.org/group/tmrg",
    [ andrew ],
    nil,
    nil,
    "2011-09-26"
  )

  # T2TRG
  bormann = Person.new("Carsten", "Bormann", "cabo@tzi.org", "https://www.informatik.uni-bremen.de/~cabo/", nil)
  keranen = Person.new("Ari", "Keränen", "ari.keranen@ericsson.com", "https://www.linkedin.com/in/akeranen", nil)
  t2trg = RG.new(
    "t2trg",
    "Thing-to-Thing",
    "t2trg@irtf.org",
    nil,
    "https://t2trg.github.io/",
    [ bormann, keranen ],
    nil,
    "2015-12-02",
    nil
  )

  # UFMRG
  hoyland = Person.new("Jonathan", "Hoyland", "jonathan.hoyland@gmail.com", "https://datatracker.ietf.org/person/jonathan.hoyland@gmail.com", nil)
  farrell = Person.new("Stephen", "Farrell", "stephen.farrell@cs.tcd.ie", "https://www.scss.tcd.ie/Stephen.Farrell/", nil)
  ufmrg = RG.new(
    "ufmrg",
    "Usable Formal Methods",
    "ufmrg@irtf.org",
    nil,
    nil,
    [ hoyland, farrell ],
    nil,
    "2023-01-27",
    nil
  )

  # VNRG
  touch = Person.new("Joe", "Touch", "touch@isi.edu", nil, nil)
  stiemerling = Person.new("Martin", "Stiemerling", "mls.ietf@gmail.com", "https://fbi.h-da.de/personen/martin-stiemerling/", nil)
  vnrg = RG.new(
    "vnrg",
    "Virtual Networks",
    "vnrg@irtf.org",
    nil,
    "https://wiki.ietf.org/group/vnrg",
    [ touch, stiemerling ],
    nil,
    nil,
    "2012-02-08"
  )

  # Active RGs
  $rgs = {
    "cfrg"  => cfrg,
    "dinrg" => dinrg,
    "gaia" => gaia,
    "hrpc" => hrpc,
    "iccrg" => iccrg,
    "icnrg" => icnrg,
    "maprg" => maprg,
    "nmrg"  => nmrg,
    "panrg" => panrg,
    "pearg" => pearg,
    "qirg" => qirg,
    "rasprg" => rasprg,
    "sustain" => sustain,
    "t2trg" => t2trg,
    "ufmrg" => ufmrg
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
  $oldrgs["sdnrg"] = sdnrg;
  $oldrgs["nfvrg"] = nfvrg;
  $oldrgs["nwcrg"] = nwcrg;
  $oldrgs["coinrg"] = coinrg;
  

  # RG pattern
  $rgpat = Regexp.new('\b(' + $rgs.keys.compact.join("|") + ')\b', true);

  # IRSG
  eggert = Person.new("Lars", "Eggert", "lars@netapp.com", "https://eggert.org/", "584143839")
  ford = Person.new("Mat", "Ford", "ford@isoc.org", "https://www.internetsociety.org/who-we-are/people/mr-mat-ford", nil)
  # atlas = Person.new("Alia", "Atlas", "akatlas@gmail.com", "https://www.ietf.org/iesg/bio/alia-atlas.html", nil)
  # trammell = Person.new("Brian", "Trammell", "ietf@trammell.ch", "https://trammell.ch/", nil)
  # linkova = Person.new("Jen", "Linkova", "furry13@gmail.com", "https://www.linkedin.com/in/furry", nil)
  falk = Person.new("Aaron", "Falk", "aaron.falk@gmail.com", "https://linkedin.com/in/aaronfalk", nil)
  # allman = Person.new("Mark", "Allman", "mallman@icir.org", "https://www.icir.org/mallman/", nil)
  dawkins = Person.new("Spencer", "Dawkins", "spencerdawkins.ietf@gmail.com", "https://linkedin.com/in/spencerdawkins", nil)
  # arkko = Person.new("Jari", "Arkko", "jari.arkko@piuha.net", "https://www.arkko.com/", nil)
  # li = Person.new("Xing", "Li", "xing@cernet.edu.cn", "https://www.net-glyph.org/lixing/", nil)
  # lear = Person.new("Eliot", "Lear", "lear@cisco.com", "https://linkedin.com/pub/eliot-lear/0/81/b0a", nil)
  # housley = Person.new("Russ", "Housley", "housley@vigilsec.com", "https://linkedin.com/pub/russ-housley/0/69/419", nil)
  # droms = Person.new("Ralph", "Droms", "rdroms.ietf@gmail.com", "https://www.linkedin.com/pub/ralph-droms/0/493/a10", nil)
  # nordmark = Person.new("Erik", "Nordmark", "nordmark@sonic.net", "https://www.linkedin.com/pub/erik-nordmark/10/243/771", nil)
  # feamster = Person.new("Nick", "Feamster", "feamster@cs.princeton.edu", "https://www.cs.princeton.edu/~feamster/", nil)
  # teixeira = Person.new("Renata", "Cruz Teixeira", "renata.teixeira@inria.fr", "https://who.rocq.inria.fr/Renata.Teixeira/", nil)
  shore = Person.new("Melinda", "Shore", "melinda.shore@nomountain.net", "https://www.linkedin.com/in/melindashore/", nil)
  iyengar = Person.new("Jana", "Iyengar", "jri.ietf@gmail.com", "https://github.com/janaiyengar", nil)
  perkins = Person.new("Colin", "Perkins", "csp@csperkins.org", "https://csperkins.org/", nil)
  #  $chair = $perkins
  $chair = kutscher
  #   $atlarge = [ ford, eggert, falk, dawkins, shore, iyengar ]
  $atlarge = [ ford, eggert, perkins] 

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
