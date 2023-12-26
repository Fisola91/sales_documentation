require "rails_helper"

RSpec.describe "User", type: :system do
  let(:user) { create(:user)}

  it "registers new user" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Register"

    expect(page).to have_link("Register")

    fill_in "Email", with: "miga@gmail.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"

    click_on "Sign up"

    expect(page).to have_content("Welcome, miga@gmail.com")
    expect(page).to have_link("Sign out")
  end

  it "signs users in" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Login"

    expect(page).to have_link("Sign up")
    expect(page).to have_link("Forgot your password?")

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Log in"

    expect(page).to have_content("Welcome, #{user.email}")
    expect(page).to have_link("Sign out")
  end

  it "signs out user" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Login"

    expect(page).to have_link("Sign up")
    expect(page).to have_link("Forgot your password?")

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Log in"

    expect(page).to have_content("Welcome, #{user.email}")

    click_on "Sign out"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")
  end
end