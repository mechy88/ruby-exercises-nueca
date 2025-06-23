# frozen_string_literal: true

require_relative 'dispatcher'
require_relative 'local_processing_system'

def run_simulation_a(customers)
  dispatcher = Dispatcher.new(customers)
  tellers = LocalProcessingSystem.new
  minutes = 0.0

  until tellers.finished? && dispatcher.finished?
    minutes += 1
    serving = dispatcher.dispatch

    queue_a(serving, tellers)

    tellers.process
  end
  minutes
end

def run_simulation_b(customers)
  dispatcher = Dispatcher.new(customers)
  tellers = LocalProcessingSystem.new
  minutes = 0.0

  until tellers.finished? && dispatcher.finished?
    minutes += 1
    serving = dispatcher.dispatch

    queue_b(serving, tellers)

    tellers.process
  end
  minutes
end

def queue_a(serving, tellers)
  serving.each do |customer|
    fall_in_line_random(customer, tellers)
  end
end

def queue_b(serving, tellers)
  serving.each do |customer|
    finish_time_a = Dispatcher.queue_compute(tellers.tell_a)
    finish_time_b = Dispatcher.queue_compute(tellers.tell_b)
    finish_time_c = Dispatcher.queue_compute(tellers.tell_c)

    fall_in_line_efficient(customer, tellers, finish_time_a, finish_time_b, finish_time_c)
  end
end

def fall_in_line_efficient(customer, tellers, a_queue, b_queue, c_queue)
  if c_queue < b_queue && c_queue < a_queue
    tellers.push_c(customer * tellers.multiplier_c)
  elsif b_queue < a_queue
    tellers.push_b(customer * tellers.multiplier_b)
  else
    tellers.push_a(customer * tellers.multiplier_a)
  end
end

def fall_in_line_random(customer, tellers)
  lines = [
    { line: tellers.tell_a, multiplier: tellers.multiplier_a },
    { line: tellers.tell_b, multiplier: tellers.multiplier_b },
    { line: tellers.tell_c, multiplier: tellers.multiplier_c }
  ]
  min = lines.min_by { |line| line[:line].length }
  min = min[:line].length
  mins = lines.select { |queue| queue[:line].length == min }
  chosen = mins.sample
  chosen[:line].push(customer * chosen[:multiplier])
end
