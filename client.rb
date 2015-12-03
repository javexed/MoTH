#/bin/ruby
require 'drb'

# We create a DRbObject instance that is connected to our server.
# All methods executed on this object will be executed to the remote one.
obj = DRbObject.new(nil, 'druby://0.0.0.0:9050')

#puts obj[:counter]
#obj.inc(:counter)
#puts obj[:counter]

puts "Call Count = #{obj.call_count}"
puts obj.place_call("SIP","18002686021","sip-provider")
#obj.place_call("SIP","18775350554","sip-provider")
puts "Call Count = #{obj.call_count}"
