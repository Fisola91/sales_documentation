require 'rails_helper'

RSpec.describe 'Dashboard', type: :system do
  let(:user) { create(:user) }
  let!(:order) {
    [
      create_list(:order, 5, user: user, date: '2023-10-22'),
      create_list(:order, 5, user: user, date: '2023-10-23'),
      create_list(:order, 5, user: user, date: '2023-10-24'),
      create_list(:order, 5, user: user, date: '2023-10-25')
    ].flatten
  }

  before do
    login_as user
  end

  it "displays page table headings" do
    visit dashboard_index_path
    expect(page).to have_content("Recent sales")
    expect(page).to have_link("all sales")
    expect(page).to have_link("Enter sales")

    within ("#all-sales-table thead tr") do
      expect(page).to have_content("Date")
      expect(page).to have_content("Earnings")
      expect(page).to have_content("See details")
    end
  end

  it "shows ground total for the sum rows for different dates" do
    visit dashboard_index_path

    within ("#all-sales-table tbody") do
      expect(page).to have_content('2023-10-24')
      expect(page).to have_content('100.0')
    end

    within ("#all-sales-table tfoot") do
      expect(page).to have_content('Total')
      expect(page).to have_content('400.0')
    end
  end

  context "Charts" do
    it "displays sales chart" do
      visit dashboard_index_path

      click_on "monthly sales"
      expect(page).to have_css("#month")

      click_on "weekly sales"
      expect(page).to have_css("#week")

      click_on "Last 10 days sales"
      expect(page).to have_css("#day")
    end
  end
end