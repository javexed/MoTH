class DrbEndpoint
  def call_count
    Adhearsion.active_calls.count
  end
  def place_call(channel,number=nil, provider=nil)
    if number.nil?
      number = channel
      channel = "SIP"
    else
      provider = provider + "/nj" if channel.downcase == 'local'
    end
    unless provider.nil?
      call = Adhearsion::OutboundCall.originate "#{channel}/#{number}@#{provider}" #, controller: IvrValidator
    else
      call = Adhearsion::OutboundCall.originate "#{channel}/#{number}"
    end
    call.id
  end
end
