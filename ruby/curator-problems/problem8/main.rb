input = gets.to_i

def fib_recur(n)
  if n <= 1
    return n
  else
    return (fib(n-1) + fib(n-2))
  end
end

def fib_iter(n)
  if n <= 1
    return n
  else
    x = 0
    y = 1
    for a in 1..n do
      z = x + y
      x = y
      y = z
    end
    return x
  end
end

puts fib_iter(input)