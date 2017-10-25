#!/usr/bin/ruby env
#Encoding: UTF-8
# Written by Tom Porter
# Twitter @porterhau5
# 10/24/17

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

  waters_array = ["Arroyo","Bay","Bend","Canal","Channel","Falls","Glacier","Gut","Harbor","Lake","Rapids","Reservoir","Sea","Spring","Stream","Swamp"]

  buildings_array = ["Airport","Bridge","Building","Cemetery","Church","Crossing","Dam","Hospital","Military","Mine","Oilfield","Post Office","School","Tower","Tunnel","Well"]

  lands_array = ["Arch","Area","Bench","Cliff","Crater","Flat","Forest","Gap","Levee","Park","Pillar","Plain","Range","Reserve","Ridge","Slope","Summit","Valley","Woods"]

  islands_array = ["Bar","Basin","Beach","Cape","Island","Isthmus"]

  waters = []
  buildings = []
  lands = []
  islands = []

  CSV.foreach(file, encoding: "iso-8859-1", headers: :first_row, col_sep: "|", quote_char: "\x00") do |row|
    if waters_array.include? row[2] then waters << row[1].gsub(" (historical)","") end
    if buildings_array.include? row[2] then buildings << row[1].gsub(" (historical)","") end
    if lands_array.include? row[2] then lands << row[1].gsub(" (historical)","") end
    if islands_array.include? row[2] then islands << row[1].gsub(" (historical)","") end
  end

  waters.sort!.uniq!
  buildings.sort!.uniq!
  lands.sort!.uniq!
  islands.sort!.uniq!

  path = "#{mapping[boundary]}"
  FileUtils.mkdir_p(path)

  File.open("#{path}/waters.txt","w" ) do |f|
    waters.each {|l| f.puts(l)}
  end

  File.open("#{path}/buildings.txt","w" ) do |f|
    buildings.each {|l| f.puts(l)}
  end

  File.open("#{path}/lands.txt","w" ) do |f|
    lands.each {|l| f.puts(l)}
  end

  File.open("#{path}/islands.txt","w" ) do |f|
    islands.each {|l| f.puts(l)}
  end

end
