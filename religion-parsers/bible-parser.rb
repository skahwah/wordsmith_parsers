#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @kawabungah
# 10/6/17

def parse_religion(f)
  word_array = Array.new
  symbols_arr = ["\,",".",";","\'","\"",")","(","?","!","&","*","\\","/"]

  file = File.open(f, "rb", :encoding => "ISO-8859-1:UTF-8")
  contents = file.read

  contents.split(" ").each do |word|
    symbols_arr.each do |symbol|
      word.gsub!(symbol,"")
      word.gsub!(/[A-Za-z]:/,"")
        word_array.push word
      end
  end

  word_array.sort!.uniq!
  return word_array
end

def output(arr,output_file)
  File.open(output_file,"w" ) do |f|
    arr.each {|line| f.puts(line)}
  end
end

f = "./douay-rheims.txt"
output_file = "./douay-rheims-parsed.txt"

#f = "./king-james-bible.txt"
#output_file = "./king-james-bible-parsed.txt"

arr = Array.new
arr = parse_religion(f)
output(arr,output_file)
