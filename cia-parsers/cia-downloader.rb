#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @hackerjiv
# 10/6/17

require 'rubygems'
require 'open-uri'
require 'nokogiri'

# this method opens up a remote URL
def nokogiri_open_url(url)
  begin
    page = Nokogiri::HTML(open(url))
  rescue OpenURI::HTTPError => e
    puts "Can't access: #{url}"
    puts "Error Message: #{e.message}"
  end
end

# download page
def download_page(page)
  # content will go to the content div which contains all of the useful data
  content = page.at('#content').children
  content_arr = Array.new
  # take the massive content string and split it on a new line. Each new line is a array element
  content_arr = content.to_s.force_encoding("iso-8859-1").split(/\n/)
  return content_arr
end

# index_array is going to hold the line number where <div id='field' exists
# The data we want is between each <div id='field'
def find_field(content_arr)
  index_array = Array.new

  for i in 0 .. content_arr.length
    current = content_arr[i].to_s
    if current.include? "id=\"field"
      index_array.push i
    end
  end

  return index_array
end


# grab the region and country name for the page
def country(page)
  # content will go to the content div which contains all of the useful data
  location_arr = Array.new
  location_arr.push "Region\n"
  region = page.css('.printHeader').inner_html.split("::")[0]
  location_arr.push region
  location_arr.push ""
  location_arr.push "Country\n"
  country = page.css('.printHeader').inner_html.split(">")[1].split("<")[0]
  location_arr.push country
  location_arr.push ""
end

# this method is used in the parser where the HTML in the content_array need to be converted into a Nokogiri object
def nokogiri_open_arr(arr)
  begin
    page = Nokogiri::HTML(arr.join(" "))
  rescue OpenURI::HTTPError => e
    puts "Can't access: #{arr}"
    puts "Error Message: #{e.message}"
  end
end

# all conceiveable two character country names (aa - zz)
countries_arr = ("aa".."zz").to_a

for i in 0 .. countries_arr.length - 1

  country_code = countries_arr[i].to_s

  url = "https://www.cia.gov/library/publications/the-world-factbook/geos/print_#{country_code}.html"

  STDOUT.sync = true
  puts "[+] Attempting to open page for #{country_code}"
  page = nokogiri_open_url(url)

  if page != nil

    puts "[+] Downloading page for #{country_code}"
    content_arr = download_page(page)
    index_array = find_field(content_arr)
    puts "[+] Parsing page for #{country_code}"

    location_arr = country(page)

    # country = complete_countries_arr.grep(/^#{country_code}/).to_s.split(",")[2]

    country_from_page = location_arr[4].to_s

    #country = complete_countries_arr.grep(/^#{country_from_page}/).to_s.split(",")[2]

    output_arr = Array.new

    output_arr.push location_arr

    # this will parse and format all data between each <div id='field'
    for i in 0 .. index_array.length - 2
      current_field = index_array[i]
      next_field =  index_array[i+1]

      arr = content_arr[current_field..next_field]
      page = nokogiri_open_arr(arr)

      output_arr.push page.css("#field a")[0].inner_html.split(":")[0]
      output_arr.push page.css(".category_data").inner_html
      output_arr.push ""
    end

    Dir.mkdir "cia" unless File.exists?("cia")

    File.open("cia/#{country_from_page}.txt","w" ) do |f|
      output_arr.each {|line| f.puts(line)}
    end

    puts "[+] Saved to #{Dir.pwd}/cia/#{country_from_page}.txt"
  end
  puts ""
  STDOUT.flush
end
