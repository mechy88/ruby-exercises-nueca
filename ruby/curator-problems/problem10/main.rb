input = ARGV[0].to_i

for i in 1..input do
  if ((i % 3 == 0) && (i % 5 == 0))
    print "RockAndRoll"
  elsif i % 3 == 0
    print "Rock"
  elsif i % 5 == 0
    print "Roll"
  else
    print i
  end
  if !(i == input) 
    print " "
  end
end

puts