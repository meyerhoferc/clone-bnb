require 'rubygems'
require 'twilio-ruby'

class TwilioService
  attr_reader :code
  def initialize
    @client = Twilio::REST::Client.new(ENV['TWILIO_TEST_SID'], ENV['TWILIO_TEST_TOKEN'])
    @account = @client.account
  end

  def send_password_code(phone_number)
    @code = generate_code
    @account.messages.create(
    from: ENV['TWILIO_TEST_PHONE'],
    to: sanitized(phone_number),
    body: @code
    )
    @code
  end

  def generate_code
    rand(10000..99999)
  end

  def sanitized(number)
    number
  end
end
