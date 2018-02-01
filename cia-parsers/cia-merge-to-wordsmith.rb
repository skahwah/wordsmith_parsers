#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @kawabungah
# 10/6/17

require 'fileutils'

path = Dir.pwd + "/cia/"

test_arr = Dir.entries(path)

wordsmith_path = "../data/"

for i in 2 .. test_arr.length - 1
  current = test_arr[i].to_s.split("-")[0]
  begin
    FileUtils.mv("#{path}#{current}.yaml","#{wordsmith_path}#{current}/#{current}.yaml")
  rescue Errno::ENOENT => e
    # do things for appropriate error handling
    puts e.message
  end

  begin
    FileUtils.mv("#{path}#{current}-cia.txt","#{wordsmith_path}#{current}/#{current}-cia.txt")
  rescue Errno::ENOENT => e
    # do things for appropriate error handling
    puts e.message
  end
end
