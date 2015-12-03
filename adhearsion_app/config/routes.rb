# encoding: utf-8

require 'call_controllers/outbound_call_controller'

Adhearsion.router do
  # This requires the call being routed to be an object of the type specified.
  route 'Outbound Calls', OutboundCallController, Adhearsion::OutboundCall

  # Specify your call routes, directing calls with particular attributes to a controller
  
  route 'default', OutboundCallController
end
