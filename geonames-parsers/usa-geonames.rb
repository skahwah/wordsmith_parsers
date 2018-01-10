#!/usr/bin/ruby env
#Encoding: UTF-8
# Written by Tom Porter
# Twitter @porterhau5
# 01/10/18

require 'csv'
require 'fileutils'

mapping = Hash.new

CSV.foreach("mappings.csv") do |row|
 mapping[row[0]] = row[1] 
end

all_files = Dir.glob("usa/*.txt")

all_files.each do |file|
  # pull out two-letter state name, convert to lower
  boundary = file.split("/")[1].split("_")[0].downcase
  puts "boundary #{boundary}"
  puts "mapping #{mapping[boundary]}"

  waters_array = ["Arroyo","Bar","Basin","Bay","Beach","Bend","Canal","Cape","Channel","Falls","Glacier","Gut","Harbor","Island","Isthmus","Lake","Rapids","Reservoir","Sea","Spring","Stream","Swamp"]

  structures_array = ["Airport","Bridge","Building","Cemetery","Church","Crossing","Dam","Hospital","Military","Mine","Oilfield","Post Office","School","Tower","Tunnel","Well"]

  lands_array = ["Arch","Area","Bench","Cliff","Crater","Flat","Forest","Gap","Lava","Levee","Park","Pillar","Plain","Range","Reserve","Ridge","Slope","Summit","Trail","Valley","Woods"]

  places_array = ["Census","Civil","Locale","Populated Place"]

  waters = []
  structures = []
  lands = []
  places = []

  CSV.foreach(file, encoding: "iso-8859-1", headers: :first_row, col_sep: "|", quote_char: "\x00") do |row|
    if waters_array.include? row[2] then waters << row[1].gsub(" (historical)","").gsub(" Historic District","") end
    if structures_array.include? row[2] then structures << row[1].gsub(" (historical)","").gsub(" Historic District","") end
    if lands_array.include? row[2] then lands << row[1].gsub(" (historical)","").gsub(" Historic District","") end
    if places_array.include? row[2] then places << row[1].gsub(" (historical)","").gsub(" Census Designated Place","").gsub(" Historic District","") end
  end

  waters.sort!.uniq!
  structures.sort!.uniq!
  lands.sort!.uniq!
  places.sort!.uniq!

  path = "#{mapping[boundary]}"
  FileUtils.mkdir_p(path)

  File.open("#{path}/waters.txt","w" ) do |f|
    waters.each {|l| f.puts(l)}
  end

  File.open("#{path}/structures.txt","w" ) do |f|
    structures.each {|l| f.puts(l)}
  end

  File.open("#{path}/lands.txt","w" ) do |f|
    lands.each {|l| f.puts(l)}
  end

  File.open("#{path}/places.txt","w" ) do |f|
    places.each {|l| f.puts(l)}
  end

end
