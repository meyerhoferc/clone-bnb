require 'rails_helper'

describe TwilioService do
  describe "#send_password_code" do
    xit "can send a message" do
      user = Fabricate(:user, phone_number: "+15202621279")
      service = TwilioService.new
      code = service.send_password_code(user.phone_number)
      expect(code).to be_truthy
    end
  end

  describe "#sanitize" do
    xit "formats the user phone number" do
      service = TwilioService.new
      expect(service.sanitize("5202221199")).to eq("+15202221199")
    end
  end
end
