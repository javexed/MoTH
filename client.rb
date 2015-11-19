require 'drb'

# We create a DRbObject instance that is connected to our server.
# All methods executed on this object will be executed to the remote one.
obj = DRbObject.new(nil, 'druby://localhost:9050')

#puts obj[:counter]
#obj.inc(:counter)
#puts obj[:counter]

puts "Call Count = #{obj.call_count}"
#puts "Last access time = #{obj[:lastaccess]}"
#obj[:lastaccess] = Time.now
