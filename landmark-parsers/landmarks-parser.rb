#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @kawabungah
# 10/6/17

require 'nokogiri'
require 'open-uri'


def output(file,arr)
  File.open("./landmarks/#{file}.txt","a" ) do |f|
    arr.each {|line| f.puts(line)}
  end
end

def atags(url)
  doc = Nokogiri::HTML(open(url))
  links = doc.css('a')
  inner = links.map {|link| link.text.to_s}.uniq.sort.delete_if{|href| href.empty?}

  inner_arr = []

  for i in 0 .. inner.length - 1
    inner_arr.push inner[i]
    inner_arr.push inner[i].to_s.gsub(" ","\n")
    inner_arr.push inner[i].to_s.gsub("\"","")
    inner_arr = inner_arr.uniq
    inner_arr = inner_arr.sort
  end
  return inner_arr
end

arr = []
#IO.foreach("List of archaeological sites by country - Wikipedia.htm") {|x| arr.push x }
IO.foreach("Lists of tourist attractions - Wikipedia.htm") {|x| arr.push x }

country = ""
link = ""
link_arr = []

for i in 0 .. arr.length
  if arr[i].to_s.include? "mw-headline"
      country = arr[i].split("id=\"")[1].split("\"")[0]
    end
  if arr[i].to_s.include? "href"
    unless arr[i].to_s.include? "jpg"
      unless arr[i].to_s.include? "JPG"
        unless arr[i].to_s.include? ";section="
          unless arr[i].to_s.include? ";redlink="
            link = "https://en.wikipedia.org" + arr[i].split("href=\"")[1].split("\"")[0]
            link_arr.push "#{country.upcase} #{link}"
          end
        end
      end
    end
  end
end

for i in 0 .. link_arr.length - 1
  country = link_arr[i].to_s.split[0]
  link = link_arr[i].to_s.split[1]
  puts "[+] (#{i}/#{link_arr.length-1}) #{link}"
  arr = atags(link)
  output(country,arr)
end
