#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @hackerjiv
# 10/6/17

# get a listing of all demographic files and load full path into array
def file_path_to_arr(path)
  all_files_arr = Dir.entries(path)
  file_path = Array.new
  # starts at 2 because of . and .. directory listings
  for i in 2 .. all_files_arr.length - 1
    file_path.push path + all_files_arr[i]
  end
  return file_path
end

# read a file line-by-line into an array
def file_to_arr(file_name)
  file_arr = Array.new
  if File.exist? file_name
    File.foreach(file_name) do |line|
      file_arr.push line
    end
  end
  return file_arr
end

# search a cia demographic file for a demographic header, such as Location, Religion, etc and return the value for this header (on the next line)
def search_demographic(file_path,demographic_header)
  file = IO.readlines(file_path, :encoding => "ISO-8859-1:UTF-8")
  demographic_index = file.index{ |line| line =~ /#{demographic_header}/ } # line number in the file where the demographic header was found

  if demographic_index == nil # if the demographic_index is nil, then the search term was not found, as such return not found
    return "[!] #{demographic_header}_Not_Found"
  else
    return demographic_value = file[demographic_index + 1].to_s # The line after the search term will be the actual value
  end
end

# search a cia demographic file for the population value
def search_population(file_arr)
  population_index = 0

  for line in 0 .. file_arr.length-1
    if file_arr[line].eql? "Population\n"
      population_index = line + 1 # line number in the file where "Population" was found +1 for the next line where the numeric value resides
    end
  end

  if population_index > 0 # if the index is nil, then the search term was not found, as such return not found
    return file_arr[population_index].split(" ")[0].to_s
    .gsub("does", "")
    .gsub("this", "")
    .gsub("Saint", "")
    .gsub("estimates", "")
    .gsub("increased", "")
    .gsub("most", "")
    .gsub("prior", "")
    .gsub("results", "")
    .gsub("Macau\'s", "")
    .gsub("Millersville", "")
    .gsub("American", "")
    .gsub("the", "")
    .gsub("in", "")
    .gsub("estimate", "")
    .gsub("Statistics", "")
    .gsub("no", "[!] Population_Not_Found")
    .gsub("uninhabitedtransient", "[!] Population_Not_Found")
    .gsub("approximately", "[!] Population_Not_Found")
    .gsub("uninhabited", "0")
  else
    return "[!] Population_Not_Found"
  end
end

def search_language(file_path)
    # for a demographic header
    demographic_header = "Language"
    search_demographic(file_path,demographic_header)
end

# population to yaml
def population_to_yaml(file_path)
  puts "[+] Population to YAML"
  for i in 0 .. file_path.length-1
    file_name = Array.new
    STDOUT.sync = true
    file_name = file_to_arr(file_path[i])
    current_country = file_path[i].split("/")[-1].split("-")[0]
    population = search_population(file_name)
    path = Dir.pwd + "/cia/"
    output = File.open("#{path}#{current_country}.yaml","w")
    if population != "[!] Population_Not_Found"
      output << "config:\n"
      output << "  population: " + population.gsub(".",",")
      output << "\n"
    end
    output.close
    STDOUT.flush
  end
end

#language to yaml
def language_to_yaml(file_path)
  puts "[+] Language to YAML"
  for i in 0 .. file_path.length-1
    STDOUT.sync = true
    current_country = file_path[i].split("/")[-1].split("-")[0]
    header = "Language"
    first_lang = search_demographic(file_path[i],header).split(/[0-9]/)[0].split("(")[0]
    second_lang = search_demographic(file_path[i],header).split(",")[1]
    path = Dir.pwd + "/cia/"
    output = File.open("#{path}#{current_country}.yaml","a")

    if current_country == "cmr"
      first_lang = "French"
    end

    if current_country == "mhl"
      second_lang = nil
    end

    if first_lang != "[!] Language_Not_Found"
      first_lang = first_lang.to_s
      .gsub("Afghan Persian or Dari","Dari")
      .gsub("Bangla","Bengali")
      .gsub("Standard Chinese or Mandarin","Chinese")
      .gsub("Danish, Faroese, Greenlandic","Danish")
      .gsub("Standard Arabic","Arabic")
      .gsub("Castilian Spanish","Spanish")
      .gsub("Englishthe following are recognized regional languages: Scots","English")
      .gsub("English, French, Norman-French dialect spoken in country districts","English")
      .gsub(", English, Nordic languages, German widely spoken","")
      .gsub(", English patois","")
      .gsub(", English","")
      .gsub("Spanish only","Spanish")
      .gsub("Bokmal Norwegian","Norwegian")
      .gsub(", Russian","")
      .gsub("English and Tongan","English")
      .gsub("Kiswahili or Swahili","Swahili")
      .gsub("Mandarin Chinese","Mandarin")
      .gsub(", Latin, French, various other languages","")
      .gsub(", French patois","")
      .gsub("local languages","English")
      .gsub(", Hebrew","")
      .gsub("English, Manx Gaelic","English")
      .gsub("Kinyarwanda only","Kinyarwanda")
      .gsub("Philippine languages","Filipino")
      output <<  "  language_1: " + first_lang
      output << "\n"
      if second_lang != nil
        second_lang = second_lang.to_s.split(/[0-9]/)[0].split("(")[0]
        .gsub("Fon and Yoruba","")
        .gsub("Kirundi and other language","")
        .gsub("native African languages belonging to Sudanic family spoken by","")
        .gsub("also known as Bengali)","")
        .gsub("based on the Beijing dialect)","Mandarin")
        .gsub("English and French widely understood by educated classes","English")
        .gsub("declining regional dialects and languages","")
        .gsub("French patois","French")
        .gsub("modified form of Malay)","Malay")
        .gsub("the language generally used)","Irish")
        .gsub(")","")
        .gsub("other","")
        .gsub(" widely spoken","")
        .gsub("some","")
        .gsub("which is virtually the same as Romanian;","")
        .gsub("dialect of Sinhala","")
        .gsub("Spanish and indigenous languages","")
        .gsub("other languages","")
        .gsub("Niuean and English","English")
        .gsub("a distinct Pacific Island language)","")
        .gsub("indigenous languages","")
        .gsub("other Micronesian","")
        .gsub("English commonly used as a second language","English")
        .gsub("universal Bantu vernacular)","")
        .gsub("regular use limited to literate minority","")
        .gsub("according to the","Arabic")
        .gsub("used for government business","siSwati")
        .gsub("the language of commerce","")
        .gsub("Russian widely used in government and businessdifferent ethnic groups speak Uzbek","Russian")
        .gsub("one of the languages of commerce","French")
        .gsub("taught in grade schools","")
        .gsub("numerous indigenous dialects","")
        .gsub(" or Spanish Creole","")
        .gsub("Azeri Turkic and Turkic dialects","Turkic")
        .gsub("universal Bantu vernacular","Bantu")
        .gsub("Lingala and Monokutuba","Lingala")
        .gsub("Cook Islands Maori","Maori")
        .gsub("Hassaniya Arabic","Arabic")
        .gsub("Antiguan creole","Creole")
        .gsub("Serbo-Croatian","Serbian")
        .gsub("Caribbean Hindustani","Hindi")
        .gsub(" Micronesian","Micronesian")
        if second_lang.length > 2
          output << "  language_2:" + second_lang
          output << "\n"
        end
      end
    end
    output.close
    STDOUT.flush
  end
end

#religion to yaml
def religion_to_yaml(file_path)
  puts "[+] Religion to YAML"
  for i in 0 .. file_path.length-1
    STDOUT.sync = true
    current_country = file_path[i].split("/")[-1].split("-")[0]
    header = "Religion"
    first_religion = search_demographic(file_path[i],header).split(",")[0]
    second_religion = search_demographic(file_path[i],header).split(",")[1]
    path = Dir.pwd + "/cia/"
    output = File.open("#{path}#{current_country}.yaml","a")
    if first_religion != "[!] Language_Not_Found"
      first_religion = first_religion.to_s.split(/[0-9]/)[0].split("(")[0]
      .gsub("nominally ","")
      .gsub("eclectic mixture of local religions","Buddhist")
      .gsub("traditionally Buddhist and Confucianist","Buddhist")
      output << "  religion_1: " + first_religion
      output << "\n"
      if second_religion != nil
        unless second_religion.include?("other")
          unless second_religion.include?("none")
            second_religion = second_religion.to_s.split(/[0-9]/)[0].split("(")[0]
            .gsub("Indian- and Nepalese-influenced Hinduism","Hindu")
            .gsub("&lt;","")
            .gsub("although traditional beliefs and taboos may still be found)","")
            .gsub("traditionally Buddhist and Confucianist","Buddhist")
            .gsub("according to the","")
            .gsub("small Christian minority","Christian")
            .gsub("Congregational Christian Church","Christian")
            .gsub("Protestant/Evangelical","Protestant")
            .gsub("non-Catholic Christians","Christian")
            .gsub("indigenous beliefs","")
            .gsub("Church of Norway","Protestant")
            if second_religion.length > 2
              output << "  religion_2:" + second_religion
              output << "\n"
            end
          end
        end
      end
    end
    output.close
    STDOUT.flush
  end
end

path = Dir.pwd + "/cia/"
file_path = file_path_to_arr(path)

population_to_yaml(file_path)
language_to_yaml(file_path)
religion_to_yaml(file_path)
