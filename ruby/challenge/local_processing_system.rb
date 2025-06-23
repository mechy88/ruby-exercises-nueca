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
