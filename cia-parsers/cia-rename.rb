#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @kawabungah
# 10/6/17

require 'fileutils'

complete_countries_arr = ["af,afg,AFGHANISTAN",
"ax,ala,ALAND ISLANDS",
"al,alb,ALBANIA",
"dz,dza,ALGERIA",
"as,asm,AMERICAN SAMOA",
"ad,and,ANDORRA",
"ao,ago,ANGOLA",
"ai,aia,ANGUILLA",
"aq,ata,ANTARCTICA",
"ag,atg,ANTIGUA AND BARBUDA",
"ar,arg,ARGENTINA",
"am,arm,ARMENIA",
"aw,abw,ARUBA",
"au,aus,AUSTRALIA",
"at,aut,AUSTRIA",
"az,aze,AZERBAIJAN",
"bs,bhs,BAHAMAS",
"bh,bhr,BAHRAIN",
"bd,bgd,BANGLADESH",
"bb,brb,BARBADOS",
"by,blr,BELARUS",
"be,bel,BELGIUM",
"bz,blz,BELIZE",
"bj,ben,BENIN",
"bm,bmu,BERMUDA",
"bt,btn,BHUTAN",
"bo,bol,BOLIVIA",
"ba,bih,BOSNIA AND HERZEGOVINA",
"bw,bwa,BOTSWANA",
"bv,bvt,BOUVET ISLAND",
"br,bra,BRAZIL",
"vg,vgb,BRITISH VIRGIN ISLANDS",
#"io,iot,BRITISH INDIAN OCEAN TERRITORY", this will throw off india
"bn,brn,BRUNEI DARUSSALAM",
"bg,bgr,BULGARIA",
"bf,bfa,BURKINA FASO",
"bi,bdi,BURUNDI",
"kh,khm,CAMBODIA",
"cm,cmr,CAMEROON",
"ca,can,CANADA",
"cv,cpv,CAPE VERDE",
"ky,cym,CAYMAN ISLANDS",
"cf,caf,CENTRAL AFRICAN REPUBLIC",
"td,tcd,CHAD",
"cl,chl,CHILE",
"cn,chn,CHINA",
"hk,hkg,HONG KONG",
"mo,mac,MACAO",
"cx,cxr,CHRISTMAS ISLAND",
"cc,cck,COCOS (KEELING) ISLANDS",
"co,col,COLOMBIA",
"km,com,COMOROS",
"cg,cog,CONGO (BRAZZAVILLE)",
"cd,cod,CONGO (KINSHASA)",
"ck,cok,COOK ISLANDS",
"cr,cri,COSTA RICA",
"ci,civ,CÔTE D'IVOIRE",
"hr,hrv,CROATIA",
"cu,cub,CUBA",
"cy,cyp,CYPRUS",
"cz,cze,CZECH REPUBLIC",
"dk,dnk,DENMARK",
"dj,dji,DJIBOUTI",
"dm,dma,DOMINICA",
"do,dom,DOMINICAN REPUBLIC",
"ec,ecu,ECUADOR",
"eg,egy,EGYPT",
"sv,slv,EL SALVADOR",
"gq,gnq,EQUATORIAL GUINEA",
"er,eri,ERITREA",
"ee,est,ESTONIA",
"et,eth,ETHIOPIA",
"fk,flk,FALKLAND ISLANDS (MALVINAS)",
"fo,fro,FAROE ISLANDS",
"fj,fji,FIJI",
"fi,fin,FINLAND",
"fr,fra,FRANCE",
"gf,guf,FRENCH GUIANA",
"pf,pyf,FRENCH POLYNESIA",
"tf,atf,FRENCH SOUTHERN TERRITORIES",
"ga,gab,GABON",
"gm,gmb,GAMBIA",
"ge,geo,GEORGIA",
"de,deu,GERMANY",
"gh,gha,GHANA",
"gi,gib,GIBRALTAR",
"gr,grc,GREECE",
"gl,grl,GREENLAND",
"gd,grd,GRENADA",
"gp,glp,GUADELOUPE",
"gu,gum,GUAM",
"gt,gtm,GUATEMALA",
"gg,ggy,GUERNSEY",
"gn,gin,GUINEA",
"gw,gnb,GUINEA-BISSAU",
"gy,guy,GUYANA",
"ht,hti,HAITI",
"hm,hmd,HEARD AND MCDONALD ISLANDS",
"va,vat,HOLY SEE (VATICAN CITY STATE)",
"hn,hnd,HONDURAS",
"hu,hun,HUNGARY",
"is,isl,ICELAND",
"in,ind,INDIA",
"id,idn,INDONESIA",
"ir,irn,IRAN",
"iq,irq,IRAQ",
"ie,irl,IRELAND",
"im,imn,ISLE OF MAN",
"il,isr,ISRAEL",
"it,ita,ITALY",
"jm,jam,JAMAICA",
"jp,jpn,JAPAN",
"je,jey,JERSEY",
"jo,jor,JORDAN",
"kz,kaz,KAZAKHSTAN",
"ke,ken,KENYA",
"ki,kir,KIRIBATI",
"kp,prk,KOREA (NORTH)",
"kr,kor,KOREA (SOUTH)",
"kw,kwt,KUWAIT",
"kg,kgz,KYRGYZSTAN",
"la,lao,LAO PDR",
"lv,lva,LATVIA",
"lb,lbn,LEBANON",
"ls,lso,LESOTHO",
"lr,lbr,LIBERIA",
"ly,lby,LIBYA",
"li,lie,LIECHTENSTEIN",
"lt,ltu,LITHUANIA",
"lu,lux,LUXEMBOURG",
"mk,mkd,MACEDONIA",
"mg,mdg,MADAGASCAR",
"mw,mwi,MALAWI",
"my,mys,MALAYSIA",
"mv,mdv,MALDIVES",
"ml,mli,MALI",
"mt,mlt,MALTA",
"mh,mhl,MARSHALL ISLANDS",
"mq,mtq,MARTINIQUE",
"mr,mrt,MAURITANIA",
"mu,mus,MAURITIUS",
"yt,myt,MAYOTTE",
"mx,mex,MEXICO",
"fm,fsm,MICRONESIA",
"md,mda,MOLDOVA",
"mc,mco,MONACO",
"mn,mng,MONGOLIA",
"me,mne,MONTENEGRO",
"ms,msr,MONTSERRAT",
"ma,mar,MOROCCO",
"mz,moz,MOZAMBIQUE",
"mm,mmr,MYANMAR",
"na,nam,NAMIBIA",
"nr,nru,NAURU",
"np,npl,NEPAL",
"nl,nld,NETHERLANDS",
"an,ant,NETHERLANDS ANTILLES",
"nc,ncl,NEW CALEDONIA",
"nz,nzl,NEW ZEALAND",
"ni,nic,NICARAGUA",
"ne,ner,NIGER",
"ng,nga,NIGERIA",
"nu,niu,NIUE",
"nf,nfk,NORFOLK ISLAND",
"mp,mnp,NORTHERN MARIANA ISLANDS",
"no,nor,NORWAY",
"om,omn,OMAN",
"pk,pak,PAKISTAN",
"pw,plw,PALAU",
"ps,pse,PALESTINIAN TERRITORY",
"pa,pan,PANAMA",
"pg,png,PAPUA NEW GUINEA",
"py,pry,PARAGUAY",
"pe,per,PERU",
"ph,phl,PHILIPPINES",
"pn,pcn,PITCAIRN",
"pl,pol,POLAND",
"pt,prt,PORTUGAL",
"pr,pri,PUERTO RICO",
"qa,qat,QATAR",
"re,reu,RÉUNION",
"ro,rou,ROMANIA",
"ru,rus,RUSSIAN FEDERATION",
"rw,rwa,RWANDA",
"bl,blm,SAINT-BARTHÉLEMY",
"sh,shn,SAINT HELENA",
"kn,kna,SAINT KITTS AND NEVIS",
"lc,lca,SAINT LUCIA",
"mf,maf,SAINT-MARTIN",
"pm,spm,SAINT PIERRE AND MIQUELON",
"vc,vct,SAINT VINCENT AND GRENADINES",
"ws,wsm,SAMOA",
"sm,smr,SAN MARINO",
"st,stp,SAO TOME AND PRINCIPE",
"sa,sau,SAUDI ARABIA",
"sn,sen,SENEGAL",
"rs,srb,SERBIA",
"sc,syc,SEYCHELLES",
"sl,sle,SIERRA LEONE",
"sg,sgp,SINGAPORE",
"sk,svk,SLOVAKIA",
"si,svn,SLOVENIA",
"sb,slb,SOLOMON ISLANDS",
"so,som,SOMALIA",
"za,zaf,SOUTH AFRICA",
"gs,sgs,SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS",
"ss,ssd,SOUTH SUDAN",
"es,esp,SPAIN",
"lk,lka,SRI LANKA",
"sd,sdn,SUDAN",
"sr,sur,SURINAME",
"sj,sjm,SVALBARD AND JAN MAYEN ISLANDS",
"sz,swz,SWAZILAND",
"se,swe,SWEDEN",
"ch,che,SWITZERLAND",
"sy,syr,SYRIA",
"tw,twn,TAIWAN",
"tj,tjk,TAJIKISTAN",
"tz,tza,TANZANIA",
"th,tha,THAILAND",
"tl,tls,TIMOR-LESTE",
"tg,tgo,TOGO",
"tk,tkl,TOKELAU",
"to,ton,TONGA",
"tt,tto,TRINIDAD AND TOBAGO",
"tn,tun,TUNISIA",
"tr,tur,TURKEY",
"tm,tkm,TURKMENISTAN",
"tc,tca,TURKS AND CAICOS ISLANDS",
"tv,tuv,TUVALU",
"ug,uga,UGANDA",
"ua,ukr,UKRAINE",
"ae,are,UNITED ARAB EMIRATES",
"gb,gbr,UNITED KINGDOM",
"us,usa,UNITED STATES OF AMERICA",
"um,umi,US MINOR OUTLYING ISLANDS",
"uy,ury,URUGUAY",
"uz,uzb,UZBEKISTAN",
"vu,vut,VANUATU",
"ve,ven,VENEZUELA",
"vn,vnm,VIET NAM",
"vi,vir,VIRGIN ISLANDS",
"wf,wlf,WALLIS AND FUTUNA ISLANDS",
"eh,esh,WESTERN SAHARA",
"ye,yem,YEMEN",
"zm,zmb,ZAMBIA",
"zw,zwe,ZIMBABWE"]

path = Dir.pwd + "/cia/"

test_arr = Dir.entries(path)

# starts at 2 because of . and .. directory listings
for i in 2 .. test_arr.length - 1
  current = test_arr[i].to_s.split(".txt")[0]
  puts "[*] File name is #{current}.txt"
  puts "[*] Searching through country code array"

  if complete_countries_arr.grep(/#{current}/) != nil
      country_code = complete_countries_arr.grep(/#{current}/).to_s.split(",")[1]
    if country_code != nil
      puts "[+] Match! UN country code is: #{country_code}"
      FileUtils.mv("#{path}#{current}.txt", "#{path}#{country_code}-cia.txt")
      puts "[+] File renamed to #{country_code}-cia.txt"
    else
      puts "[!] No Match!"
    end
  end
  puts ""
end

puts "[+] Going through manual renames"
begin
  FileUtils.mv("#{path}BAHAMAS, THE.txt", "#{path}bhs-cia.txt")
  FileUtils.mv("#{path}BURMA.txt", "#{path}mmr-cia.txt")
  FileUtils.mv("#{path}COCOS (KEELING) ISLANDS.txt", "#{path}cck-cia.txt")
  FileUtils.mv("#{path}CONGO, DEMOCRATIC REPUBLIC OF THE.txt", "#{path}cod-cia.txt")
  FileUtils.mv("#{path}CONGO, REPUBLIC OF THE.txt", "#{path}cog-cia.txt")
  FileUtils.mv("#{path}COTE D'IVOIRE.txt", "#{path}civ-cia.txt")
  FileUtils.mv("#{path}CZECHIA.txt", "#{path}cze-cia.txt")
  FileUtils.mv("#{path}FALKLAND ISLANDS (ISLAS MALVINAS).txt", "#{path}flk-cia.txt")
  FileUtils.mv("#{path}GAMBIA, THE.txt", "#{path}gmb-cia.txt")
  FileUtils.mv("#{path}HEARD ISLAND AND MCDONALD ISLANDS.txt", "#{path}hmd-cia.txt")
  FileUtils.mv("#{path}HOLY SEE (VATICAN CITY).txt", "#{path}vat-cia.txt")
  FileUtils.mv("#{path}KOREA, NORTH.txt", "#{path}prk-cia.txt")
  FileUtils.mv("#{path}KOREA, SOUTH.txt", "#{path}kor-cia.txt")
  FileUtils.mv("#{path}LAOS.txt", "#{path}lao-cia.txt")
  FileUtils.mv("#{path}PITCAIRN ISLANDS.txt", "#{path}pcn-cia.txt")
  FileUtils.mv("#{path}SAINT BARTHELEMY.txt", "#{path}blm-cia.txt")
  FileUtils.mv("#{path}SAINT HELENA, ASCENSION, AND TRISTAN DA CUNHA.txt", "#{path}shn-cia.txt")
  FileUtils.mv("#{path}SAINT MARTIN.txt", "#{path}maf-cia.txt")
  FileUtils.mv("#{path}SAINT VINCENT AND THE GRENADINES.txt", "#{path}vct-cia.txt")
  FileUtils.mv("#{path}SOUTH GEORGIA AND SOUTH SANDWICH ISLANDS.txt", "#{path}sgs-cia.txt")
  FileUtils.mv("#{path}VIETNAM.txt", "#{path}vnm-cia.txt")
  FileUtils.mv("#{path}MACAU.txt", "#{path}mac-cia.txt")
  FileUtils.mv("#{path}CABO VERDE.txt", "#{path}cpv-cia.txt")
  FileUtils.mv("#{path}CURACAO.txt", "#{path}cuw-cia.txt")
  FileUtils.mv("#{path}HOWLAND ISLAND.txt", "#{path}hwl-cia.txt")
  FileUtils.mv("#{path}GAZA STRIP.txt", "#{path}pse-cia.txt")
  FileUtils.mv("#{path}KOSOVO.txt", "#{path}rks-cia.txt")
  FileUtils.mv("#{path}MICRONESIA, FEDERATED STATES OF.txt", "#{path}fsm-cia.txt")
  FileUtils.mv("#{path}MIDWAY ISLANDS.txt", "#{path}mdw-cia.txt")
  FileUtils.mv("#{path}JOHNSTON ATOLL.txt", "#{path}jon-cia.txt")
  FileUtils.mv("#{path}JARVIS ISLAND.txt", "#{path}jar-cia.txt")
  FileUtils.mv("#{path}CLIPPERTON ISLAND.txt", "#{path}cpt-cia.txt")
  FileUtils.mv("#{path}PALMYRA ATOLL.txt", "#{path}plm-cia.txt")
  FileUtils.mv("#{path}SPRATLY ISLANDS.txt", "#{path}xsp-cia.txt")
  FileUtils.mv("#{path}WAKE ISLAND.txt", "#{path}wak-cia.txt")
  FileUtils.mv("#{path}WEST BANK.txt", "#{path}xwb-cia.txt")
  FileUtils.mv("#{path}CORAL SEA ISLANDS.txt", "#{path}csi-cia.txt")
  FileUtils.mv("#{path}BRITISH INDIAN OCEAN TERRITORY.txt", "#{path}iot-cia.txt")
  FileUtils.mv("#{path}SINT MAARTEN.txt", "#{path}sxm-cia.txt")
rescue Errno::ENOENT => e
  # do things for appropriate error handling
  puts e.message
end

#clean up

FileUtils.rm("#{path}ARCTIC OCEAN.txt")
FileUtils.rm("#{path}AKROTIRI.txt")
FileUtils.rm("#{path}ASHMORE AND CARTIER ISLANDS.txt")
FileUtils.rm("#{path}ATLANTIC OCEAN.txt")
FileUtils.rm("#{path}BAKER ISLAND.txt")
FileUtils.rm("#{path}DHEKELIA.txt")
FileUtils.rm("#{path}EUROPEAN UNION.txt")
FileUtils.rm("#{path}FRENCH SOUTHERN AND ANTARCTIC LANDS.txt")
FileUtils.rm("#{path}INDIAN OCEAN.txt")
FileUtils.rm("#{path}KINGMAN REEF.txt")
FileUtils.rm("#{path}NAVASSA ISLAND.txt")
FileUtils.rm("#{path}PACIFIC OCEAN.txt")
FileUtils.rm("#{path}PARACEL ISLANDS.txt")
FileUtils.rm("#{path}SOUTHERN OCEAN.txt")
FileUtils.rm("#{path}UNITED STATES PACIFIC ISLAND WILDLIFE REFUGES.txt")
FileUtils.rm("#{path}WORLD.txt")

#unable to find country codes at this time
#FileUtils.mv("#{path}AKROTIRI.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}ARCTIC OCEAN.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}DHEKELIA.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}WORLD.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}ASHMORE AND CARTIER ISLANDS.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}ATLANTIC OCEAN.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}BAKER ISLAND.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}EUROPEAN UNION.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}FRENCH SOUTHERN AND ANTARCTIC LANDS.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}PACIFIC OCEAN.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}SOUTHERN OCEAN.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}PARACEL ISLANDS.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}KINGMAN REEF.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}NAVASSA ISLAND.txt", "#{path}#{country_code}-cia.txt")
#FileUtils.mv("#{path}UNITED STATES PACIFIC ISLAND WILDLIFE REFUGES.txt", "#{path}#{country_code}-cia.txt")


#https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
#https://en.wikipedia.org/wiki/List_of_NATO_country_codes
