require 'rails_helper'

describe "traveler can see their inbox" do
  it "when they visit dashboard" do
    traveler_1 = Fabricate(:user)
    traveler_1.roles.create!(title: "traveler")
    traveler_2 = Fabricate(:user)
    traveler_2.roles.create!(title: "traveler")
    host = Fabricate(:user)
    host.roles.create!(title: "host")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    conversation_1 = Conversation.create!(initiator_id: traveler_1.id, recipient_id: host.id)
    conversation_2 = Conversation.create!(initiator_id: traveler_2.id, recipient_id: host.id)
    message_1 = conversation_1.messages.create!(user_id: traveler_1.id, body: "msg test 1")
    message_1 = conversation_2.messages.create!(user_id: traveler_2.id, body: "msg test 1")

    visit ("/dashboard")

    click_on "Messages"

    expect(page).to have_content("#{traveler_1.first_name}")
    expect(page).to have_content("#{traveler_2.first_name}")

    click_on "#{traveler_1.first_name}"

    expect(page).to have_content
    within(".card") do
      expect(page).to have_content("msg test 1")
    end
    within(".card") do
      expect(page).to_not have_content("msg test 2")
    end
  end
end
