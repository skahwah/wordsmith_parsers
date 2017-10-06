#!/usr/bin/ruby env
#Encoding: UTF-8
# Written by Tom Porter
# Twitter @porterhau5
# 10/6/17

require 'csv'
require 'fileutils'

# ----
# section below for usa national last names

# this assumes the names.zip (File B) has been downloaded from
# https://www.census.gov/topics/population/genealogy/data/2010_surnames.html
# and unzipped to a directory called "lastnames/"

puts "make sure output path in code is correct"
path = "../../data/usa"

names = []

CSV.foreach("lastnames/Names_2010Census.csv", {:headers=>:first_row}) do |row|
  # sample data row
  # SMITH,1,2442977,828.19,828.19,70.9,23.11,0.5,0.89,2.19,2.4
  # skip last row which starts with "ALL OTHER NAMES"
  next unless row[0] != "ALL OTHER NAMES"
  names.push(row[0].to_s.downcase.capitalize)
end

FileUtils.mkdir_p(path)
File.open("#{path}/lnames.txt","w" ) do |f|
  names.each do |name|
    f.puts "#{name}"
  end
end

puts "end last names parsing"


# ----
# section below for usa national first names

# this assumes the names.zip has been downloaded from https://www.ssa.gov/oact/babynames/limits.html
# and unzipped to a directory called "national/"

all_files = Dir.glob("national/yob*.txt")
#names = Hash.new(0)
names = Hash.new { |h,k| h[k] = [] }
all_files.each do |file|
  # sample row of data looks like this:
  # Emma,F,19414
  # add indicators for female and male names
  CSV.foreach(file, converters: :numeric) do |row|
    if row[1] == "F"
      # if hash has key (e.g. "f,Emma", then add to it's value)
      if names.has_key?("f," + row[0])
        names["f," + row[0]][0] += row[2].to_i
      # otherwise, create the hash[key]
      else
        names["f," + row[0]] << row[2].to_i
      end
    else
      if names.has_key?("m," + row[0])
        names["m," + row[0]][0] += row[2].to_i
      else
        names["m," + row[0]] << row[2].to_i
      end
    end
  end
end

# reverse sort the hash, most popular first
names = names.sort_by {|k, v| v}.reverse

path = "../../data/usa"
#FileUtils.mkdir_p(path)
#File.open("#{path}/fnames.txt","w" ) do |f|
#  names.each do |key, value|
#    val = value[0].to_s
#    f.puts "#{key},#{val}"
#  end
#end

puts "end national data"

# ----
# section below for generating state-by-state first names

# this assumes the namesbystate.zip has been downloaded from https://www.ssa.gov/oact/babynames/limits.html
# and unzipped to a directory called "bystate/"
all_files = Dir.glob("bystate/*.TXT")

all_files.each do |file|
  # pull out two-letter state name, convert to lower
  state = file.split("/")[1].split(".")[0].downcase
  puts "state #{state}"

  names = []

  # sample row of data looks like this:
  # NC,F,1910,Mary,837
  # add indicators for female and male names
  CSV.foreach(file, converters: :numeric) do |row|
    if row[1] == "F"
      names << ["f," + row[3], row[4]]
    else
      names << ["m," + row[3], row[4]]
    end
  end

  # sum up the values of each unique name
  names = names.each_with_object(Hash.new(0)) { |(k, v), h| h[k] += v }
  # reverse sort the hash, most popular first
  names = names.sort_by {|k, v| v}.reverse

  #path2 = "#{path}/#{state}"
  #FileUtils.mkdir_p(path)
  #File.open("#{path2}/fnames.txt","w" ) do |f|
  #  names.each do |key, value|
  #    f.puts "#{key},#{value}"
  #  end
  #end

end
