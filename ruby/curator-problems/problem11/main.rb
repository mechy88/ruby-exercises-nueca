input = ARGV
target = "Nemo"
if !(input.include?(target))
  puts "Nemo is missing."
else
  puts input.find_index { |i| i == target}
end
