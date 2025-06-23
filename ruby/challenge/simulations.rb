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

    queue_b(serving, tellers, dispatcher)

    tellers.process
  end
  minutes
end

def queue_a(serving, tellers)
  serving.each do |customer|
    fall_in_line_random(customer, tellers)
  end
end

def queue_b(serving, tellers, dispatcher)
  serving.each do |customer|
    a = dispatcher.queue_compute(tellers.tell_a)
    b = dispatcher.queue_compute(tellers.tell_b)
    c = dispatcher.queue_compute(tellers.tell_c)

    fall_in_line_efficient(customer, tellers, a, b, c)
  end
end

def fall_in_line_efficient(customer, tellers, a_queue, b_queue, c_queue)
  if c_queue < b_queue && c_queue < a_queue
    tellers.push_c(customer * tellers.c)
  elsif b_queue < a_queue
    tellers.push_b(customer * tellers.b)
  else
    tellers.push_a(customer * tellers.a)
  end
end

def fall_in_line_random(customer, tellers)
  lines = [
    { line: tellers.tell_a, multiplier: tellers.a },
    { line: tellers.tell_b, multiplier: tellers.b },
    { line: tellers.tell_c, multiplier: tellers.c }
  ]
  min = lines.min_by { |line| line[:line].length }
  min = min[:line].length
  mins = lines.select { |queue| queue[:line].length == min }
  chosen = mins.sample
  chosen[:line].push(customer * chosen[:multiplier])
end
