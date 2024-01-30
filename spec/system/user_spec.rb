require "rails_helper"

RSpec.describe "User", type: :system do
  let(:user) { create(:user)}

  it "registers new user" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    find(".register").click

    expect(page).to have_link("Register")

    fill_in "Username", with: "Suyi"
    fill_in "Email", with: "suyi@gmail.com"
    fill_in "user_password", with: "123456"

    click_on "Sign up"
    expect(page).to have_link("Sign out")
  end

  it "signs users in" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Login"

    expect(page).to have_button("Log in")
    expect(page).to have_link("Forgot your password?")

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password

    click_on "Log in"

    expect(page).to have_link("Sign out")
  end

  it "signs out user" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Login"

    expect(page).to have_button("Log in")
    expect(page).to have_link("Forgot your password?")

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password

    click_on "Log in"

    click_on "Sign out"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")
  end

  it "returns error when user sign in with wrong credentials" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    click_on "Login"

    fill_in "Username", with: "Bobo"
    fill_in "Password", with: "abbey"

    click_on "Log in"

    expect(page).to have_button("Log in")
    expect(page).to have_link("Forgot your password?")

    expect(page).to have_content("Invalid Username or password")
  end

  it "sees content of the homepage before login" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    expect(page).to have_content("Harness the power of data to drive growth and elevate your business success.")
    expect(page).to have_content("Benefits")
  end
end