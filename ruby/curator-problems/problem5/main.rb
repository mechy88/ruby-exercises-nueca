input = ARGV
target = input[0]
puts target

def is_palindrome string
  string.upcase
  last = string.length - 1
  for i in 0..last
    if string[i] != string[last-i]
      return false
    end
  end

  return true
end

if is_palindrome(target)
  puts "\"#{target}\" is a Palindrome!"
else
  puts "\"#{target}\" is NOT a Palindrome!"
end