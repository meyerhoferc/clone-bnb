require 'rails_helper'

describe "user can see their inbox" do
  it "when they visit dashboard" do
    user_1, user_2 = Fabricate.times(2, :user)
    user_1.roles.create!(title: "traveler")
    user_2.roles.create!(title: "traveler")
    host = Fabricate(:user)
    host.roles.create!(title: "host")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(host)
    conversation_1 = Conversation.create!(initiator_id: user_1.id, recipient_id: host.id)
    conversation_2 = Conversation.create!(initiator_id: user_2.id, recipient_id: host.id)
    message_1 = conversation_1.messages.create!(user_id: user_1.id, body: "msg test 1")
    message_1 = conversation_2.messages.create!(user_id: user_2.id, body: "msg test 2")

    visit ("/dashboard")

    click_on "Messages"
save_and_open_page
binding.pry
    expect(page).to have_content("Mailbox")
    expect(page).to have_content("#{user_1.first_name}")
    expect(page).to have_content("#{user_2.first_name}")

    click_on "#{user_1.first_name}"

    expect(page).to have_content
    within(".card") do
      expect(page).to have_content("msg test 1")
    end
    within(".card") do
      expect(page).to_not have_content("msg test 2")
    end
  end
end
