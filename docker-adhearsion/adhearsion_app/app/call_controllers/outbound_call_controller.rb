# encoding: utf-8

class OutboundCallController < Adhearsion::CallController

  before_call do
    @recording = nil
  end

  def run
    answer
    # Unsure why this is required, but recording doesn't seem to work without playing something
    play 'file://custom_scripts/20ms-silence'
    record_result = record :final_timemout => 1, :max_duration => 30 do |event|
      logger.info "Recording saved to #{event.recording.uri}"
      @recording = event.recording
    end
    hangup
  end

  after_call do
    logger.info @recording.uri
    rec_file = /(.*)\/(.*$)/.match(@recording.uri).captures.last
    rec_file.gsub!(/\.wav$/, "-in.wav")
    c=Stomp::Client.new("stomp://localhost:61613")
    c.publish("/queue/fingerprint", rec_file)
  end

end
