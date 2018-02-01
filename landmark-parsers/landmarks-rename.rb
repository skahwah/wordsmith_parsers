#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @kawabungah
# 10/6/17

require 'fileutils'

complete_countries_arr = ["af,afg,AFGHANISTAN",
"ax,ala,ALAND_ISLANDS",
"al,alb,ALBANIA",
"dz,dza,ALGERIA",
"as,asm,AMERICAN_SAMOA",
"ad,and,ANDORRA",
"ao,ago,ANGOLA",
"ai,aia,ANGUILLA",
"aq,ata,ANTARCTICA",
"ag,atg,ANTIGUA_AND_BARBUDA",
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
"ba,bih,BOSNIA_AND_HERZEGOVINA",
"bw,bwa,BOTSWANA",
"bv,bvt,BOUVET_ISLAND",
"br,bra,BRAZIL",
"vg,vgb,BRITISH_VIRGIN_ISLANDS",
#"io,iot,BRITISH_INDIAN_OCEAN_TERRITORY",_this_will_throw_off_india
"bn,brn,BRUNEI_DARUSSALAM",
"bg,bgr,BULGARIA",
"bf,bfa,BURKINA_FASO",
"bi,bdi,BURUNDI",
"kh,khm,CAMBODIA",
"cm,cmr,CAMEROON",
"ca,can,CANADA",
"cv,cpv,CAPE_VERDE",
"ky,cym,CAYMAN_ISLANDS",
"cf,caf,CENTRAL_AFRICAN_REPUBLIC",
"td,tcd,CHAD",
"cl,chl,CHILE",
"cn,chn,CHINA",
"hk,hkg,HONG_KONG",
"mo,mac,MACAO",
"cx,cxr,CHRISTMAS_ISLAND",
"cc,cck,COCOS_(KEELING)_ISLANDS",
"co,col,COLOMBIA",
"km,com,COMOROS",
"cg,cog,CONGO_(BRAZZAVILLE)",
"cd,cod,CONGO_(KINSHASA)",
"ck,cok,COOK_ISLANDS",
"cr,cri,COSTA_RICA",
"ci,civ,CÔTE_D'IVOIRE",
"hr,hrv,CROATIA",
"cu,cub,CUBA",
"cy,cyp,CYPRUS",
"cz,cze,CZECH_REPUBLIC",
"dk,dnk,DENMARK",
"dj,dji,DJIBOUTI",
"dm,dma,DOMINICA",
"do,dom,DOMINICAN_REPUBLIC",
"ec,ecu,ECUADOR",
"eg,egy,EGYPT",
"sv,slv,EL_SALVADOR",
"gq,gnq,EQUATORIAL_GUINEA",
"er,eri,ERITREA",
"ee,est,ESTONIA",
"et,eth,ETHIOPIA",
"fk,flk,FALKLAND_ISLANDS_(MALVINAS)",
"fo,fro,FAROE_ISLANDS",
"fj,fji,FIJI",
"fi,fin,FINLAND",
"fr,fra,FRANCE",
"gf,guf,FRENCH_GUIANA",
"pf,pyf,FRENCH_POLYNESIA",
"tf,atf,FRENCH_SOUTHERN_TERRITORIES",
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
"hm,hmd,HEARD_AND_MCDONALD_ISLANDS",
"va,vat,HOLY_SEE_(VATICAN_CITY_STATE)",
"hn,hnd,HONDURAS",
"hu,hun,HUNGARY",
"is,isl,ICELAND",
"in,ind,INDIA",
"id,idn,INDONESIA",
"ir,irn,IRAN",
"iq,irq,IRAQ",
"ie,irl,IRELAND",
"im,imn,ISLE_OF_MAN",
"il,isr,ISRAEL",
"it,ita,ITALY",
"jm,jam,JAMAICA",
"jp,jpn,JAPAN",
"je,jey,JERSEY",
"jo,jor,JORDAN",
"kz,kaz,KAZAKHSTAN",
"ke,ken,KENYA",
"ki,kir,KIRIBATI",
"kp,prk,KOREA_(NORTH)",
"kr,kor,KOREA_(SOUTH)",
"kw,kwt,KUWAIT",
"kg,kgz,KYRGYZSTAN",
"la,lao,LAO_PDR",
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
"mh,mhl,MARSHALL_ISLANDS",
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
"nl,nld,THE_NETHERLANDS",
"an,ant,NETHERLANDS_ANTILLES",
"nc,ncl,NEW_CALEDONIA",
"nz,nzl,NEW_ZEALAND",
"ni,nic,NICARAGUA",
"ne,ner,NIGER",
"ng,nga,NIGERIA",
"nu,niu,NIUE",
"nf,nfk,NORFOLK_ISLAND",
"mp,mnp,NORTHERN_MARIANA_ISLANDS",
"no,nor,NORWAY",
"om,omn,OMAN",
"pk,pak,PAKISTAN",
"pw,plw,PALAU",
"ps,pse,PALESTINIAN_TERRITORY",
"pa,pan,PANAMA",
"pg,png,PAPUA_NEW_GUINEA",
"py,pry,PARAGUAY",
"pe,per,PERU",
"ph,phl,PHILIPPINES",
"pn,pcn,PITCAIRN",
"pl,pol,POLAND",
"pt,prt,PORTUGAL",
"pr,pri,PUERTO_RICO",
"qa,qat,QATAR",
"re,reu,RÉUNION",
"ro,rou,ROMANIA",
"ru,rus,RUSSIAN_FEDERATION",
"rw,rwa,RWANDA",
"bl,blm,SAINT-BARTHÉLEMY",
"sh,shn,SAINT_HELENA",
"kn,kna,SAINT_KITTS_AND_NEVIS",
"lc,lca,SAINT_LUCIA",
"mf,maf,SAINT-MARTIN",
"pm,spm,SAINT_PIERRE_AND_MIQUELON",
"vc,vct,SAINT_VINCENT_AND_GRENADINES",
"ws,wsm,SAMOA",
"sm,smr,SAN_MARINO",
"st,stp,SAO_TOME_AND_PRINCIPE",
"sa,sau,SAUDI_ARABIA",
"sn,sen,SENEGAL",
"rs,srb,SERBIA",
"sc,syc,SEYCHELLES",
"sl,sle,SIERRA_LEONE",
"sg,sgp,SINGAPORE",
"sk,svk,SLOVAKIA",
"si,svn,SLOVENIA",
"sb,slb,SOLOMON_ISLANDS",
"so,som,SOMALIA",
"za,zaf,SOUTH_AFRICA",
"gs,sgs,SOUTH_GEORGIA_AND_THE_SOUTH_SANDWICH_ISLANDS",
"ss,ssd,SOUTH_SUDAN",
"es,esp,SPAIN",
"lk,lka,SRI_LANKA",
"sd,sdn,SUDAN",
"sr,sur,SURINAME",
"sj,sjm,SVALBARD_AND_JAN_MAYEN_ISLANDS",
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
"tt,tto,TRINIDAD_AND_TOBAGO",
"tn,tun,TUNISIA",
"tr,tur,TURKEY",
"tm,tkm,TURKMENISTAN",
"tc,tca,TURKS_AND_CAICOS_ISLANDS",
"tv,tuv,TUVALU",
"ug,uga,UGANDA",
"ua,ukr,UKRAINE",
"ae,are,UNITED_ARAB_EMIRATES",
"gb,gbr,UNITED_KINGDOM",
"us,usa,UNITED_STATES_OF_AMERICA",
"um,umi,US_MINOR_OUTLYING_ISLANDS",
"uy,ury,URUGUAY",
"uz,uzb,UZBEKISTAN",
"vu,vut,VANUATU",
"ve,ven,VENEZUELA",
"vn,vnm,VIET_NAM",
"vi,vir,VIRGIN_ISLANDS",
"wf,wlf,WALLIS_AND_FUTUNA_ISLANDS",
"eh,esh,WESTERN_SAHARA",
"ye,yem,YEMEN",
"zm,zmb,ZAMBIA",
"zw,zwe,ZIMBABWE",
",prk,SOUTH_KOREA",
",mac,MACAU"]


path = Dir.pwd + "/landmarks/"
wsd = "/Users/skawa/proj/GitHub/wordsmith-v2/data/"

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
      FileUtils.mv("#{path}#{current}.txt", "#{wsd}#{country_code}/landmarks.txt")
      puts "[+] File moved to #{wsd}#{country_code}/landmarks.txt"
    else
      puts "[!] No Match!"
    end
  end
  puts ""
end

=begin
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
=end
