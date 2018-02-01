#!/usr/bin/env ruby
# Written by Sanjiv Kawa
# Twitter @kawabungah
# 10/6/17

f = "../religion-original-documents/king-james-bible.txt"

file = File.open(f, "rb", :encoding => "UTF-8")
contents = file.read

arr = []

contents.split("\n").each do |word|
  if word.downcase =~ /[[\d]]/
    arr.push word.split(" ")[0]
  else
    arr.push word
  end
end

arr = arr.reject { |c| c.empty? }

book = ""

for line in 0 .. arr.length
  if arr[line] == "1:1"
    book = arr[line - 1]
    puts book
  end
  if arr[line] =~ /[[\d]]/
    puts book.gsub(" ","") + arr[line]

    puts arr[line] + book.gsub(" ","")

    puts book.gsub("The First Book of Moses: Called Genesis","Genesis")
    .gsub("The Second Book of Moses: Called Exodus","Exodus")
    .gsub("The Third Book of Moses: Called Leviticus","Leviticus")
    .gsub("The Fourth Book of Moses: Called Numbers","Numbers")
    .gsub("The Fifth Book of Moses: Called Deuteronomy","Deuteronomy")
    .gsub("The Book of Joshua","Joshua")
    .gsub("The Book of Judges","Judges")
    .gsub("The Book of Ruth","Ruth")
    .gsub("The First Book of the Kings","Samuel")
    .gsub("The Second Book of the Kings","Samuel")
    .gsub("The Third Book of the Kings","Kings")
    .gsub("The Fourth Book of the Kings","Kings")
    .gsub("The First Book of the Chronicles","Chronicles")
    .gsub("The Second Book of the Chronicles","Chronicles")
    .gsub("The Book of Nehemiah","Nehemiah")
    .gsub("The Book of Esther","Esther")
    .gsub("The Book of Job","Job")
    .gsub("The Book of Psalms","Psalms")
    .gsub("The Proverbs","Proverbs")
    .gsub("The Preacher","Preacher")
    .gsub("The Song of Solomon","Solomon")
    .gsub("The Book of the Prophet Isaiah","Isaiah")
    .gsub("The Book of the Prophet Jeremiah","Jeremiah")
    .gsub("The Lamentations of Jeremiah","Jeremiah")
    .gsub("The Book of the Prophet Ezekiel","Ezekiel")
    .gsub("The Book of Daniel","Daniel")
    .gsub("The Gospel According to Saint Matthew","Matthew")
    .gsub("The Gospel According to Saint Mark","Mark")
    .gsub("The Gospel According to Saint Luke","Luke")
    .gsub("The Gospel According to Saint John","John")
    .gsub("The Acts of the Apostles","Apostles")
    .gsub("The Epistle of Paul the Apostle to the Romans","Paul")
    .gsub("The First Epistle of Paul the Apostle to the Corinthians","Corinthians")
    .gsub("The Second Epistle of Paul the Apostle to the Corinthians","Corinthians")
    .gsub("The Epistle of Paul the Apostle to the Galatians","Galatians")
    .gsub("The Epistle of Paul the Apostle to the Ephesians","Ephesians")
    .gsub("The Epistle of Paul the Apostle to the Philippians","Philippians")
    .gsub("The Epistle of Paul the Apostle to the Colossians","Colossians")
    .gsub("The First Epistle of Paul the Apostle to the Thessalonians","")
    .gsub("The Second Epistle of Paul the Apostle to the Thessalonians","")
    .gsub("The First Epistle of Paul the Apostle to Timothy","Timothy")
    .gsub("The Second Epistle of Paul the Apostle to Timothy","Timothy")
    .gsub("The Epistle of Paul the Apostle to Titus","Titus")
    .gsub("The Epistle of Paul the Apostle to Philemon","Philemon")
    .gsub("The Epistle of Paul the Apostle to the Hebrews","Hebrews")
    .gsub("The General Epistle of James","James")
    .gsub("The First Epistle General of Peter","Peter")
    .gsub("The Second General Epistle of Peter","Peter")
    .gsub("The First Epistle General of John","John")
    .gsub("The Second Epistle General of John","John")
    .gsub("The Third Epistle General of John","John")
    .gsub("The General Epistle of Jude","Jude")
    .gsub("The Revelation of Saint John the Devine","Devine") + arr[line]

    puts arr[line] + book.gsub("The First Book of Moses: Called Genesis","Genesis")
    .gsub("The Second Book of Moses: Called Exodus","Exodus")
    .gsub("The Third Book of Moses: Called Leviticus","Leviticus")
    .gsub("The Fourth Book of Moses: Called Numbers","Numbers")
    .gsub("The Fifth Book of Moses: Called Deuteronomy","Deuteronomy")
    .gsub("The Book of Joshua","Joshua")
    .gsub("The Book of Judges","Judges")
    .gsub("The Book of Ruth","Ruth")
    .gsub("The First Book of the Kings","Samuel")
    .gsub("The Second Book of the Kings","Samuel")
    .gsub("The Third Book of the Kings","Kings")
    .gsub("The Fourth Book of the Kings","Kings")
    .gsub("The First Book of the Chronicles","Chronicles")
    .gsub("The Second Book of the Chronicles","Chronicles")
    .gsub("The Book of Nehemiah","Nehemiah")
    .gsub("The Book of Esther","Esther")
    .gsub("The Book of Job","Job")
    .gsub("The Book of Psalms","Psalms")
    .gsub("The Proverbs","Proverbs")
    .gsub("The Preacher","Preacher")
    .gsub("The Song of Solomon","Solomon")
    .gsub("The Book of the Prophet Isaiah","Isaiah")
    .gsub("The Book of the Prophet Jeremiah","Jeremiah")
    .gsub("The Lamentations of Jeremiah","Jeremiah")
    .gsub("The Book of the Prophet Ezekiel","Ezekiel")
    .gsub("The Book of Daniel","Daniel")
    .gsub("The Gospel According to Saint Matthew","Matthew")
    .gsub("The Gospel According to Saint Mark","Mark")
    .gsub("The Gospel According to Saint Luke","Luke")
    .gsub("The Gospel According to Saint John","John")
    .gsub("The Acts of the Apostles","Apostles")
    .gsub("The Epistle of Paul the Apostle to the Romans","Paul")
    .gsub("The First Epistle of Paul the Apostle to the Corinthians","Corinthians")
    .gsub("The Second Epistle of Paul the Apostle to the Corinthians","Corinthians")
    .gsub("The Epistle of Paul the Apostle to the Galatians","Galatians")
    .gsub("The Epistle of Paul the Apostle to the Ephesians","Ephesians")
    .gsub("The Epistle of Paul the Apostle to the Philippians","Philippians")
    .gsub("The Epistle of Paul the Apostle to the Colossians","Colossians")
    .gsub("The First Epistle of Paul the Apostle to the Thessalonians","")
    .gsub("The Second Epistle of Paul the Apostle to the Thessalonians","")
    .gsub("The First Epistle of Paul the Apostle to Timothy","Timothy")
    .gsub("The Second Epistle of Paul the Apostle to Timothy","Timothy")
    .gsub("The Epistle of Paul the Apostle to Titus","Titus")
    .gsub("The Epistle of Paul the Apostle to Philemon","Philemon")
    .gsub("The Epistle of Paul the Apostle to the Hebrews","Hebrews")
    .gsub("The General Epistle of James","James")
    .gsub("The First Epistle General of Peter","Peter")
    .gsub("The Second General Epistle of Peter","Peter")
    .gsub("The First Epistle General of John","John")
    .gsub("The Second Epistle General of John","John")
    .gsub("The Third Epistle General of John","John")
    .gsub("The General Epistle of Jude","Jude")
    .gsub("The Revelation of Saint John the Devine","Devine")
    end
end


#book names
=begin
.gsub("The First Book of Moses: Called Genesis","Genesis")
.gsub("The Second Book of Moses: Called Exodus","Exodus")
.gsub("The Third Book of Moses: Called Leviticus","Leviticus")
.gsub("The Fourth Book of Moses: Called Numbers","Numbers")
.gsub("The Fifth Book of Moses: Called Deuteronomy","Deuteronomy")
.gsub("The Book of Joshua","Joshua")
.gsub("The Book of Judges","Judges")
.gsub("The Book of Ruth","Ruth")
.gsub("The First Book of the Kings","Samuel")
.gsub("The Second Book of the Kings","Samuel")
.gsub("The Third Book of the Kings","Kings")
.gsub("The Fourth Book of the Kings","Kings")
.gsub("The First Book of the Chronicles","Chronicles")
.gsub("The Second Book of the Chronicles","Chronicles")
#.gsub("Ezra","")
.gsub("The Book of Nehemiah","Nehemiah")
.gsub("The Book of Esther","Esther")
.gsub("The Book of Job","Job")
.gsub("The Book of Psalms","Psalms")
.gsub("The Proverbs","Proverbs")
.gsub("The Preacher","Preacher")
.gsub("The Song of Solomon","Solomon")
.gsub("The Book of the Prophet Isaiah","Isaiah")
.gsub("The Book of the Prophet Jeremiah","Jeremiah")
.gsub("The Lamentations of Jeremiah","Jeremiah")
.gsub("The Book of the Prophet Ezekiel","Ezekiel")
.gsub("The Book of Daniel","Daniel")
#.gsub("Hosea","")
#.gsub("Joel","")
#.gsub("Amos","")
#.gsub("Obadiah","")
#.gsub("Jonah","")
#.gsub("Micah","")
#.gsub("Nahum","")
#.gsub("Habakkuk","")
#.gsub("Zephaniah","")
#.gsub("Haggai","")
#.gsub("Zechariah","")
#.gsub("Malachi","")
.gsub("The Gospel According to Saint Matthew","Matthew")
.gsub("The Gospel According to Saint Mark","Mark")
.gsub("The Gospel According to Saint Luke","Luke")
.gsub("The Gospel According to Saint John","John")
.gsub("The Acts of the Apostles","Apostles")
.gsub("The Epistle of Paul the Apostle to the Romans","Paul")
.gsub("The First Epistle of Paul the Apostle to the Corinthians","Corinthians")
.gsub("The Second Epistle of Paul the Apostle to the Corinthians","Corinthians")
.gsub("The Epistle of Paul the Apostle to the Galatians","Galatians")
.gsub("The Epistle of Paul the Apostle to the Ephesians","Ephesians")
.gsub("The Epistle of Paul the Apostle to the Philippians","Philippians")
.gsub("The Epistle of Paul the Apostle to the Colossians","Colossians")
.gsub("The First Epistle of Paul the Apostle to the Thessalonians","")
.gsub("The Second Epistle of Paul the Apostle to the Thessalonians","")
.gsub("The First Epistle of Paul the Apostle to Timothy","Timothy")
.gsub("The Second Epistle of Paul the Apostle to Timothy","Timothy")
.gsub("The Epistle of Paul the Apostle to Titus","Titus")
.gsub("The Epistle of Paul the Apostle to Philemon","Philemon")
.gsub("The Epistle of Paul the Apostle to the Hebrews","Hebrews")
.gsub("The General Epistle of James","James")
.gsub("The First Epistle General of Peter","Peter")
.gsub("The Second General Epistle of Peter","Peter")
.gsub("The First Epistle General of John","John")
.gsub("The Second Epistle General of John","John")
.gsub("The Third Epistle General of John","John")
.gsub("The General Epistle of Jude","Jude")
.gsub("The Revelation of Saint John the Devine","Devine")
=end

# The First Book of the Kings aka The First Book of Samuel
# The First Book of the Kings aka The Third Book of the Kings
# The Second Book of the Kings aka The Second Book of Samuel
# The Second Book of the Kings aka The Fourth Book of the Kings
