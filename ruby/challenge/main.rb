# Constants to account for the speed of each teller.
A = 1
B = 2
C = 3

# Returns true when the queue is finished i.e. no more customers to serve and no more customers in the queues
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
def senario_a(input)
  minutes = 0

  tell_a = []
  tell_b = []
  tell_c = []

  # do while people are still coming and the queue is not finished, this is where the minute starts
  while !finished?(tell_a, tell_b, tell_c, input.length)
    minutes += 1.0
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


    # # temp for debugging
    # p tell_a
    # p tell_b
    # p tell_c
    # puts

  end

  return minutes
end

def queue_compute(queue)
  queue.inject{ |sum, el| sum + el }.to_f
end


# will return how much time it took for that one simulation
def senario_b(input)
  minutes = 0

  tell_a = []
  tell_b = []
  tell_c = []

  # do while people are still coming and the queue is not finished, this is where the minute starts
  while !finished?(tell_a, tell_b, tell_c, input.length)
    minutes += 1.0
    # how many customers now
    rand(6).times do
      if !input.empty?
        # identify how long it takes for the tell to finish their current queue
        a = queue_compute(tell_a)
        b = queue_compute(tell_b)
        c = queue_compute(tell_c)

        # put in tell with smallest time to finish, with priority to the fastest tel
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


    # # temp for debugging
    # p tell_a
    # p tell_b
    # p tell_c
    # puts

  end

  return minutes
end



Senario_A = []
Senario_B = []

500.times do | num |

  # Generate Normal and Heavy Tasks
  input = []
  50.times do
    input.push(getTask)
  end

  # Simulate porformance for senario A
  Senario_A.push(senario_a(Marshal.load(Marshal.dump(input))))

  # Simulate performance for senario B
  Senario_B.push(senario_b(Marshal.load(Marshal.dump(input))))
end

# Get the average time it takes for senario A 
average_a = Senario_A.inject{ |sum, el| sum + el }.to_f / Senario_A.size
puts "Senario 1 took an average of " + average_a.to_s + " minutes to finish over 500 simulations"

# Get the average time it takes for senario B
average_b = Senario_B.inject{ |sum, el| sum + el }.to_f / Senario_B.size
puts "Senario 1 took an average of " + average_b.to_s + " minutes to finish over 500 simulations"