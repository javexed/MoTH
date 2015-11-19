# encoding: utf-8

class OutboundCallController < Adhearsion::CallController

  def run
    answer
    # Unsure why this is required, but recording doesn't seem to work without this
    play 'file://digits/1'
    record_result = record :final_timemout => 2, :max_duration => 60 do |event|
      logger.info "Recording saved to #{event.recording.uri}"
    end
    hangup
  end

end
