#!/usr/bin/env ruby
#Encoding: UTF-8

require 'csv'
require 'fileutils'

File.readlines('states.txt').each do |line|
  counties = []
  cities = []
  CSV.foreach('national_places.txt', col_sep: '|') { |record| 
    next unless record.length == 7
    if record[0] == line.upcase.chomp
      counties.push(*record[6].split(", "))
      cities.push(*record[3].split(", "))
    end }

  counties = counties.each { |c| c.gsub!(/ County$/,'')}
  counties = counties.each { |c| c.gsub!(/ Census Area$/,'')}
  counties = counties.each { |c| c.gsub!(/ city$/,'')}
  counties = counties.each { |c| c.gsub!(/ Parish$/,'')}
  counties = counties.each { |c| c.gsub!(/ City and Borough$/,'')}
  counties = counties.each { |c| c.gsub!(/ Borough$/,'')}
  counties = counties.each { |c| c.gsub!(/ Municipality$/,'')}
  counties = counties.each { |c| c.gsub!(/ Municipio$/,'')}
  counties.sort!.uniq!
  path = "./data/usa/#{line.chomp}"
  FileUtils.mkdir_p(path)
  File.open("./data/usa/#{line.chomp}/counties.txt","w" ) do |f|
    counties.each {|l| f.puts(l)}
  end

  cities = cities.each { |c| c.gsub!(/ \(balance\)$/,'')}
  cities = cities.each { |c| c.gsub!(/ borough$/,'')}
  cities = cities.each { |c| c.gsub!(/ CDP$/,'')}
  cities = cities.each { |c| c.gsub!(/ city$/,'')}
  cities = cities.each { |c| c.gsub!(/ charter$/,'')}
  cities = cities.each { |c| c.gsub!(/ comunidad$/,'')}
  cities = cities.each { |c| c.gsub!(/ corporation$/,'')}
  cities = cities.each { |c| c.gsub!(/ county$/,'')}
  cities = cities.each { |c| c.gsub!(/ defined$/,'')}
  cities = cities.each { |c| c.gsub!(/ gore$/,'')}
  cities = cities.each { |c| c.gsub!(/ government$/,'')}
  cities = cities.each { |c| c.gsub!(/ grant$/,'')}
  cities = cities.each { |c| c.gsub!(/ location$/,'')}
  cities = cities.each { |c| c.gsub!(/ metropolitan$/,'')}
  cities = cities.each { |c| c.gsub!(/ municipality$/,'')}
  cities = cities.each { |c| c.gsub!(/ plantation$/,'')}
  cities = cities.each { |c| c.gsub!(/ purchase$/,'')}
  cities = cities.each { |c| c.gsub!(/ town$/,'')}
  cities = cities.each { |c| c.gsub!(/ township$/,'')}
  cities = cities.each { |c| c.gsub!(/ urbana$/,'')}
  cities = cities.each { |c| c.gsub!(/ UT$/,'')}
  cities = cities.each { |c| c.gsub!(/ village$/,'')}
  cities = cities.each { |c| c.gsub!(/ zona$/,'')}
  cities.sort!.uniq!
  File.open("#{path}/cities.txt","w" ) do |f|
    cities.each {|l| f.puts(l)}
  end
end
