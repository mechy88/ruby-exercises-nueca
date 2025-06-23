# frozen_string_literal: true

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
  def self.queue_compute(queue)
    queue.inject { |sum, el| sum + el }.to_f
  end
end

def generate_task
  return 2 if rand(4).zero?

  1
end
