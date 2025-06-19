def is_palindrome string
  string = string.upcase
  last = string.length - 1
  for i in 0..last
    if string[i] != string[last-i]
      # print "Culprits #{i} #{last} #{string[i]} #{string[last-i]}"
      return false
    end
  end

  return true
end

def remove_special_characters_regex(str)
    str.gsub(/[^\w\s]/, '')
end



input = ARGV
original = input.join(" ")
target = remove_special_characters_regex(original)

if is_palindrome(target)
  puts "\"#{original}\" is a Palindrome!"
else
  puts "\"#{original}\" is NOT a Palindrome!"
end