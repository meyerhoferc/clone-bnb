Fabricate.sequence(:first_name)
Fabricate.sequence(:last_name)
Fabricate.sequence(:email)
Fabricate.sequence(:phone_number)
Fabricate.sequence(:user_photo)
Fabricate.sequence(:about_me)
Fabricate.sequence(:password_digest)

Fabricator(:user) do
  first_name { sequence(:first_name) { |i| "first_name#{i}"} }
  last_name { sequence(:last_name) { |i| "last_name#{i}"} }
  email { sequence(:email) { |i| "email#{i}"}}
  user_photo { sequence(:user_photo) { |i| "photo#{i}"}}
  phone_number { sequence(:phone_number, 8000) }
  about_me { sequence(:about_me) { |i| "aboutme#{i}"} }
  password_digest { sequence(:password_digest) { |i| "digest#{i}"} }
end
