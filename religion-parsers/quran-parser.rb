#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @kawabungah
# 10/6/17

#all_files = Dir.glob("./*.txt")
#
#data = []
#
#all_files.each do |f|
#  file = File.open(f, "rb", :encoding => "ISO-8859-1:UTF-8")
#  contents = file.read
#  file.close
#  data = data + contents.split("\n")
#end
#
#def output(arr,output_file)
#  File.open(output_file,"w" ) do |f|
#    arr.each {|line| f.puts(line)}
#  end
#end
#
#out = "./quran.txt"
#output(data,out)

def parse_religion(f)
  word_array = Array.new
  symbols_arr = ["\,",".",";","\'","\"",")","(","?","!","&","*","\\","/"]

  file = File.open(f, "rb", :encoding => "UTF-8")
  contents = file.read

  contents.split(" ").each do |word|
    symbols_arr.each do |symbol|
      word.gsub!("â","")
      word.gsub!(/\P{ASCII}/, "")
      word.gsub!(symbol,"")
      word.gsub!(/[A-Za-z]:/,"")
        word_array.push word
      end
  end

  word_array.sort!
  word_array.uniq!
  return word_array
end

def output(arr,output_file)
  File.open(output_file,"w" ) do |f|
    arr.each {|line| f.puts(line)}
  end
end

f = "./quran.txt"
output_file = "./quran-parsed-0.txt"
arr = Array.new
arr = parse_religion(f)
output(arr,output_file)

f2 = "./quran-allah.txt"
output_file = "./quran-parsed-1.txt"
arr2 = Array.new
arr2 = parse_religion(f2)
output(arr2,output_file)

%x[cat ./quran-parsed-0.txt > ./quran-parsed-2.txt]
%x[cat ./quran-parsed-1.txt >> ./quran-parsed-2.txt]

f = "./quran-parsed-2.txt"
output_file = "./quran-parsed-eng.txt"
arr = Array.new
arr = parse_religion(f)
output(arr,output_file)

%x[rm quran-parsed-[0-2].txt]
