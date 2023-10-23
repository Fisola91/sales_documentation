require 'rails_helper'

RSpec.describe "Sales per day", type: :system do
  before do
    visit '/'
    expect(page).to have_link("all sales")
    click_link "all sales"
  end

  fit "displays the form page and link to all sales page" do
    expect(page).to have_content("ALL SALES PER DAY")
  end
end