# frozen_string_literal: true

# This class contains all the Teller's queues
class LocalProcessingSystem
  attr_reader :tell_a, :tell_b, :tell_c, :multiplier_a, :multiplier_b, :multiplier_c

  def initialize
    @tell_a = []
    @tell_b = []
    @tell_c = []
    @multiplier_a = 1
    @multiplier_b = 2
    @multiplier_c = 3
  end

  # Returns true when the queue is finished i.e. no more customers in the queues
  def finished?
    @tell_a.empty? && @tell_b.empty? && @tell_c.empty?
  end

  # elapse 1 minute for a queue
  def self.process_queue(queue)
    return if queue.empty?

    front = queue[0] -= 1
    queue.shift if front.zero?
  end

  # process the queues as for 1 elapsed minute
  def process
    # elapse 1 minute for teller a, b, c
    LocalProcessingSystem.process_queue @tell_a
    LocalProcessingSystem.process_queue @tell_b
    LocalProcessingSystem.process_queue @tell_c
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
