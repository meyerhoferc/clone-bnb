require 'rails_helper'

describe TwilioService do
  it "can send a message" do
    user = Fabricate(:user, phone_number: "+15202621279")
    @service = TwilioService.new
    code = @service.send_password_code(user.phone_number)
    expect(code).to be_truthy
  end
end
