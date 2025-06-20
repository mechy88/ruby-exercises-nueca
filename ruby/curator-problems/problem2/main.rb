# Returns the value for the nth element
def element(n)
  value = ""

  base = 'a'.ord
  a = n / 26
  r = n - 26 * a

  value = value + ("a" * a)
  if r != 0
    value = value + (r + base - 1).chr
  end

  return value
end


# line = gets
# line = line.split

line = ARGV

arr = []

for a in 1..line[0].to_i do
  arr.push(element(a))
end

line = line.drop(1)

first = true
line.each do |i|
    if !first
      print " "
    end
    first = false
    print arr.fetch((i.to_i - 1), "?")
end