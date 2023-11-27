require 'rails_helper'

RSpec.describe "Registration", type: :system do
  it "registers as a new user" do
    fake_origin = "http://localhost:3030"
    fake_client = WebAuthn::FakeClient.new(fake_origin, encoding: false)
    fixed_challenge = SecureRandom.random_bytes(32)

    visit new_registration_path

    fake_credentials = fake_client.create(challenge: fixed_challenge, user_verified: true)
    allow(fake_client).to receive(:create).and_return(fake_credentials)

    fill_in "Username", with: "User1"
    fill_in "Security Key nickname", with: "USB key"
  end
end