# frozen_string_literal: true

# This class contains all the Teller's queues
class LocalProcessingSystem
  attr_accessor :tell_a, :tell_b, :tell_c

  def initialize
    @tell_a = []
    @tell_b = []
    @tell_c = []
  end

  # Returns true when the queue is finished i.e. no more customers in the queues
  def finished?
    @queue_a.empty? && @queue_b.empty? && @queue_c.empty?
  end

  # process the queues as for 1 elapsed minute
  def process
    if !@tell_a.empty?
      array[0] = array[0] - 1
    end
    # if !array.empty?
    #   array[0] = array[0] - 1
    #   if array[0] == 0
    #     array.shift
    #   end
    # end
    2
  end
end

# A static class for the dispatcher to help the queue
class Dispatcher
  
end
