class Code < ApplicationRecord
  belongs_to :user

  def twilio_service
    TwilioService.new
  end
end
