# module HashInitialized
#   def hash_initialized(*fields)
#     define_method(:initialize) do |h|
# 	    missing = fields - h.keys
#   	  raise Exception, "Not all fields set: #{missing}" if missing.any?

#       h.each do |k,v|
#         instance_variable_set("@#{k}", v) if fields.include?(k) 
#       end
#     end
#   end
# end

# class Cheese
#   extend HashInitialized
#   attr_accessor :color, :odor, :taste
#   hash_initialized :color, :odor, :taste
# end

# eden = Cheese.new({:color => "yellow", :odor => "none", :taste => "salty", :food => true})
# puts eden.color
# puts eden.odor
# puts eden.taste
# puts eden.food
# puts eden

puts false
puts not true
