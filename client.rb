#/bin/ruby
require 'drb'
require 'yaml'

# We create a DRbObject instance that is connected to our server.
# All methods executed on this object will be executed to the remote one.
obj = DRbObject.new(nil, 'druby://0.0.0.0:9050')

puts "Call Count = #{obj.call_count}"
cnf = YAML::load_file(File.join(__dir__, 'config.yml'))

while cnf['call_list']['numbers'].size > 0
  number = nil
  number = cnf['call_list']['numbers'].shift unless obj.call_count >= cnf['call_parameters']['concurrent']
  puts obj.place_call('SIP',number.to_s,'sip-provider') unless number.nil?
  sleep(1)
end

puts "Call Count = #{obj.call_count}"
