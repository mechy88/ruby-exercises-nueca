require 'benchmark'

A = 1
B = 2
C = 3

def finished?(queue_a, queue_b, queue_c, customers)
  return ( queue_a.empty? && queue_b.empty? && queue_c.empty? && (customers == 0) )
end

def process(array)
  if !array.empty?
    array[0] = array[0] - 1
    if array[0] == 0
      array.shift
    end
  end
end

def getTask
  if rand(4) == 0
    return 2
  end
  return 1
end

# will return how much time it took for that one simulation
def senario_a()
  minutes = 0

  # generate random tasks
  input = []

  50.times do
    input.push(getTask)
  end

  tell_a = []
  tell_b = []
  tell_c = []

  # do while people are still coming and the queue is not finished, this is where the minute starts
  while !finished?(tell_a, tell_b, tell_c, input.length)
    minutes += 1
    # how many customers now
    rand(6).times do
      if !input.empty?
        a = tell_a.length
        b = tell_b.length
        c = tell_c.length

        # put in tell with smallest length
        if(c < b && c < a)
          tell_c.push (input.shift * C)
          c = tell_c.length
        elsif b < a
          tell_b.push (input.shift * B)
          b = tell_b.length
        else
          tell_a.push (input.shift * A)
          a = tell_a.length
        end
      end
    end
    
    # process the queue
    process(tell_a)
    process(tell_b)
    process(tell_c)


    # temp for debugging
    p tell_a
    p tell_b
    p tell_c
    puts

  end

  return minutes
end

puts senario_a