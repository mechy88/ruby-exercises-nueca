# frozen_string_literal: true

require_relative 'simulations'

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
