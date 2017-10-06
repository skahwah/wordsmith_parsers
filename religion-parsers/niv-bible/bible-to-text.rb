#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @hackerjiv
# 10/6/17

require 'rubygems'
require 'pdfkit'
require 'peach'

def file_to_arr(f)
  symbols_arr = ["`","«","»","®","©","\,",":",".",";","\'","\"",")","(","?","!","&","*","\\","/"]
  word_array = []
  file = File.open(f, :encoding => "ISO-8859-1:UTF-8") # possibly change to ISO-8859-1:UTF-8?
  contents = file.read
  file.close

  contents.split(" ").each do |word|
    symbols_arr.each do |symbol|
      word.gsub!(symbol,"")
      word.gsub!("--","\n")
      word_array.push word
    end
  end
  return word_array
end

def output(file_arr,file_name)
  file_arr.sort!.uniq!
  file_arr = file_arr.reject {|el| el.empty?}
  File.open("#{file_name}.txt","w" ) do |f|
    file_arr.each {|line| f.puts(line)}
  end
end

f = "eng-niv.conf"
file = File.open(f, :encoding => "ISO-8859-1:UTF-8")
bible = f.split("-")[1].split(".")[0].upcase

File.readlines(f).peach(10) do |line|
  book = line.split(" ")[0]
  book_num = line.split(" ")[1].split("..")[0].to_i
  last_book = line.split(" ")[1].split("..")[1].to_i

  until book_num > last_book.to_i
    puts "[+] (#{book_num}/#{last_book}) #{book}"
    file_name = "#{bible}-#{book}-#{book_num}"

    if File.file?("#{file_name}.pdf")
      book_num = book_num + 1
    else
      kit = PDFKit.new("https://www.biblegateway.com/passage/?search=#{book}+#{book_num}&version=#{bible}&interface=print")
      kit.to_file("#{file_name}.pdf")
      `./xpdf-tools-mac-4.00/bin64/pdftotext -q #{file_name}.pdf #{file_name}-orig.txt`
      file_arr = file_to_arr("#{file_name}-orig.txt")
      output(file_arr,file_name)
      book_num = book_num + 1
    end
  end
end
