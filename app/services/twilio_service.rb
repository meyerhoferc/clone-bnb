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
    to: sanitize(phone_number),
    body: @code
    )
    @code
  end

  def generate_code
    rand(10000..99999)
  end

  def sanitize(number)
    if number[0..1] == "+1"
      number
    elsif number[0] == "1"
      number.chars.unshift("+").join
    else
      number.chars.unshift("1").unshift("+").join
    end
  end
end
