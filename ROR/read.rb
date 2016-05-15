file='address.txt'
f = File.open(file, "r")
f.each_line { |line|
  puts line
}
f.close