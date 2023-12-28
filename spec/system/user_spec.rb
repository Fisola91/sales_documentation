require "rails_helper"

RSpec.describe "User", type: :system do
  let(:user) { create(:user)}

  it "registers new user" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Register"

    expect(page).to have_link("Register")

    fill_in "Username", with: "Suyi"
    fill_in "Email", with: "suyi@gmail.com"
    fill_in "user_password", with: "123456"
    fill_in "Password confirmation", with: "123456"

    click_on "Sign up"

    expect(page).to have_content("Welcome, Suyi")
    expect(page).to have_link("Sign out")
  end

  it "signs users in" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Login"

    expect(page).to have_link("Sign up")
    expect(page).to have_link("Forgot your password?")

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password

    click_on "Log in"

    expect(page).to have_content("Welcome, #{user.username}")
    expect(page).to have_link("Sign out")
  end

  it "signs out user" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Login"

    expect(page).to have_link("Sign up")
    expect(page).to have_link("Forgot your password?")

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password

    click_on "Log in"

    expect(page).to have_content("Welcome, #{user.username}")

    click_on "Sign out"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")
  end
end