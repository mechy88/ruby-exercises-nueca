# frozen_string_literal: true

# This class contains all the Teller's queues
class LocalProcessingSystem
  attr_accessor :tell_a, :tell_b, :tell_c, :a, :b, :c

  def initialize
    @tell_a = []
    @tell_b = []
    @tell_c = []
    @a = 1
    @b = 2
    @c = 3
  end

  # Returns true when the queue is finished i.e. no more customers in the queues
  def finished?
    @tell_a.empty? && @tell_b.empty? && @tell_c.empty?
  end

  # elapse 1 minute for a queue
  def process_queue(queue)
    return if queue.empty?

    queue[0] = queue[0] - 1
    queue.shift if queue[0].zero?
  end

  # process the queues as for 1 elapsed minute
  def process
    # elapse 1 minute for teller a, b, c
    process_queue @tell_a
    process_queue @tell_b
    process_queue @tell_c
  end

  def push_a(customer)
    @tell_a.push customer
  end

  def push_b(customer)
    @tell_b.push customer
  end

  def push_c(customer)
    @tell_c.push customer
  end
end

# A static class for the dispatcher to help the queue
class Dispatcher
  def initialize(queue)
    @queue = queue
  end

  def finished?
    @queue.empty?
  end

  def dispatch
    dispatched = []
    rand(6).times do
      dispatched.push(@queue.shift) unless @queue.empty?
    end

    dispatched
  end

  # The new basis on senario 2 to optimize queues
  def queue_compute(queue)
    queue.inject { |sum, el| sum + el }.to_f
  end
end

# Returns the average time senario A takes over
def run_simulation_a(customers)
  dispatcher = Dispatcher.new(customers)
  tellers = LocalProcessingSystem.new
  minutes = 0.0

  until tellers.finished? && dispatcher.finished?
    minutes += 1
    serving = dispatcher.dispatch

    serving.each do |customer|
      a = tellers.tell_a.length
      b = tellers.tell_b.length
      c = tellers.tell_c.length

      if c < b && c < a
        tellers.push_c(customer * tellers.c)
      elsif b < a
        tellers.push_b(customer * tellers.b)
      else
        tellers.push_a(customer * tellers.a)
      end
    end

    tellers.process
  end
  minutes
end

# Returns the average time senario B takes over
def run_simulation_b(customers)
  dispatcher = Dispatcher.new(customers)
  tellers = LocalProcessingSystem.new
  minutes = 0.0

  until tellers.finished? && dispatcher.finished?
    minutes += 1
    serving = dispatcher.dispatch

    serving.each do |customer|
      a = dispatcher.queue_compute(tellers.tell_a)
      b = dispatcher.queue_compute(tellers.tell_b)
      c = dispatcher.queue_compute(tellers.tell_c)

      if c < b && c < a
        tellers.push_c(customer * tellers.c)
      elsif b < a
        tellers.push_b(customer * tellers.b)
      else
        tellers.push_a(customer * tellers.a)
      end
    end

    tellers.process
  end
  minutes
end

def generate_task
  return 2 if rand(4).zero?

  1
end

# Here is the top level code
senario_a = []
senario_b = []

500.times do
  # Generate Normal and Heavy Tasks
  input = []
  50.times do
    input.push(generate_task)
  end

  # Simulate porformance for senario A
  senario_a.push(run_simulation_a(Marshal.load(Marshal.dump(input))))

  # Simulate performance for senario B
  senario_b.push(run_simulation_b(Marshal.load(Marshal.dump(input))))
end

# Get the average time it takes for senario A
average_a = senario_a.inject { |sum, el| sum + el }.to_f / senario_a.size
puts "Senario A took an average of #{average_a} minutes to finish over 500 simulations"

# Get the average time it takes for senario B
average_b = senario_b.inject { |sum, el| sum + el }.to_f / senario_b.size
puts "Senario B took an average of #{average_b} minutes to finish over 500 simulations"
