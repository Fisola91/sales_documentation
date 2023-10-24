require 'rails_helper'

RSpec.describe "Sales per day", type: :system do
  before do
    create_list(:order, 5, created_at: '2023-10-22')
    create_list(:order, 5, created_at: '2023-10-23')
    create_list(:order, 5, created_at: '2023-10-24')
  end

  it "displays page headings and all sales summary" do
    visit '/'
    expect(page).to have_link("all sales")
    
    click_link "all sales"
    expect(page).to have_content("ALL SALES PER DAY")
   
    within ("#all-sales-table thead tr") do
      expect(page).to have_content("Date")
      expect(page).to have_content("Earnings")
      expect(page).to have_content("Total amount")
      expect(page).to have_content("See details")
    end
  end

  context "when group by date" do
    it "shows summary data for different dates" do
      visit '/'
      expect(page).to have_link("all sales")

      click_link "all sales"
      expect(page).to have_content("ALL SALES PER DAY")

      within ("#all-sales-table tbody") do
        expect(page).to have_content('2023-10-24')
      end
    end
  end
end