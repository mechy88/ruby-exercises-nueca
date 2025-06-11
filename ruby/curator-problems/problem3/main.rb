input = ARGV
first = true
input.each do |i|
    if first
      print i
      first = false
    else
      print ' '
      print i
    end
end