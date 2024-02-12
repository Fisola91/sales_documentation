require "rails_helper"

RSpec.describe "Homepage", type: :system do

  it "displays the homepage content" do
    visit "/"

    expect(page).to have_link("Login")
    expect(page).to have_link("Register")

    expect(page).to have_content("About")
    expect(page).to have_content("Benefits")
  end
end