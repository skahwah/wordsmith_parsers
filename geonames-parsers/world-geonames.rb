#!/usr/bin/ruby env
#Encoding: UTF-8
# Written by Tom Porter
# Twitter @porterhau5
# 01/11/18

require 'csv'
require 'fileutils'
require 'set'

def write_files(path)
  #puts "debug path: ${path}"
  @waters.sort!.uniq!
  @structures.sort!.uniq!
  @lands.sort!.uniq!
  @places.sort!.uniq!
    
  FileUtils.mkdir_p(path)
  waters_file = "#{path}/waters.txt"
  structures_file = "#{path}/structures.txt"
  lands_file = "#{path}/lands.txt"
  places_file = "#{path}/places.txt"

  if not @waters.empty?
    File.open(waters_file,"a" ) do |f|
      @waters.each {|l| f.puts(l)}
      @all_files.add(waters_file)
    end
  end

  if not @structures.empty?
    File.open(structures_file,"a" ) do |f|
      @structures.each {|l| f.puts(l)}
      @all_files.add(structures_file)
    end
  end
  
  if not @lands.empty?
    File.open(lands_file,"a" ) do |f|
      @lands.each {|l| f.puts(l)}
      @all_files.add(lands_file)
    end
  end
  
  if not @places.empty?
    File.open(places_file,"a" ) do |f|
      @places.each {|l| f.puts(l)}
      @all_files.add(places_file)
    end
  end
  
  @waters = []
  @structures = []
  @lands = []
  @places = []
end

def main()
  mapping = Hash.new
  @all_files = Set.new

  CSV.foreach("fips-to-data-mappings.csv") do |row|
    mapping[row[0]] = row[1] 
  end

  file = "world/Countries.txt"
  #file = "world/Countries-tmp.txt"

  # Feature Classes: http://www.geonames.org/export/codes.html
  waters_array = ["H","U"]
  structures_array = ["R","S"]
  lands_array = ["L","T","V"]
  places_array = ["A","P"]

  @waters = []
  @structures = []
  @lands = []
  @places = []
  boundary = ""
  prev_path = ""
  prev_boundary = "" #debug
  line = 1
  percent_complete = 0
  total_lines = `wc -l "#{file}"`.strip.split(' ')[0].to_i - 1
  onetenth = total_lines / 10
  progress = onetenth

  CSV.foreach(file, encoding: "iso-8859-1", headers: :first_row, col_sep: "\t", quote_char: "\x00") do |row|
    if line == progress
      percent_complete = percent_complete + 10
      progress = progress + onetenth
      puts "#{percent_complete}% complete"
    end
    cc1 = row[12].downcase
    boundaries = cc1.split(',')
    boundaries.each { |boundary|
      #puts "boundary: #{boundary}"
      #puts "mapping #{mapping[boundary]}"
      path = "#{mapping[boundary]}"
      #puts "FC: #{row[9]}"
    
      if line == 1
        prev_path = path
        prev_boundary = boundary
      end
  
      #puts "debug, line: #{line}"
  
      if path != prev_path
        #puts "debug, write_files hit, path != prev_path"
        #puts "debug, prev_boundary: #{prev_boundary}"
        #puts "debug, prev_path: #{prev_path}"
        write_files(prev_path)
        prev_path = path
        prev_boundary = boundary
      elsif line == total_lines
        #puts "debug, write_files hit, last line"
        write_files(path)
      #else
      #  puts "debug, else hit, setting prev_path"
      #  prev_path = path
      end
    
      if waters_array.include? row[9]
        @waters << row[22].gsub(" (historical)","").gsub(" Historic District","")
        @waters << row[23].gsub(" (historical)","").gsub(" Historic District","")
      end
      if structures_array.include? row[9]
        @structures << row[22].gsub(" (historical)","").gsub(" Historic District","")
        @structures << row[23].gsub(" (historical)","").gsub(" Historic District","")
      end
      if lands_array.include? row[9]
        @lands << row[22].gsub(" (historical)","").gsub(" Historic District","")
        @lands << row[23].gsub(" (historical)","").gsub(" Historic District","")
      end
      if places_array.include? row[9]
        @places << row[22].gsub(" (historical)","").gsub(" Census Designated Place","").gsub(" Historic District","")
        @places << row[23].gsub(" (historical)","").gsub(" Census Designated Place","").gsub(" Historic District","")
      end
    
      line = line + 1
    
    }
  end
    
  @all_files.each do |s|
    puts "Sorting & Uniq'ing #{s}"
    new_array = File.readlines(s).sort.uniq
    File.open(s,"w") do |file|
      file.puts new_array
    end
  end
  
  
  #puts "waters: #{waters}"
  #puts "structures: #{structures.to_s}"
  #puts "lands: #{lands.to_s}"
  #puts "places: #{places.to_s}"
end

main()
