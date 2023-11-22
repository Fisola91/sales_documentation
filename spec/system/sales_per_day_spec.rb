require 'rails_helper'

RSpec.describe "Sales per day", type: :system do
  before do
    create_list(:order, 5, date: '2023-10-22')
    create_list(:order, 5, date: '2023-10-23')
    create_list(:order, 5, date: '2023-10-24')
    create_list(:order, 5, date: '2023-10-25')
  end
  let(:today_date) { Date.today }

  it "displays page table headings" do
    visit '/'
    expect(page).to have_link("all sales")

    click_link "all sales"
    expect(page).to have_content("ALL SALES PER DAY")

    within ("#all-sales-table thead tr") do
      expect(page).to have_content("Date")
      expect(page).to have_content("Earnings")
      expect(page).to have_content("See details")
    end
  end

  context "when group by date" do
    it "shows total sum rows for different dates" do
      visit '/'
      expect(page).to have_link("all sales")

      click_link "all sales"
      expect(page).to have_content("ALL SALES PER DAY")
      expect(page).to have_link("Homepage")

      within ("#all-sales-table tbody") do
        expect(page).to have_content('2023-10-24')
      end
    end

    it "returns back to the homepage" do
      visit '/'
      expect(page).to have_link("all sales")

      click_link "all sales"
      expect(page).to have_content("ALL SALES PER DAY")
      expect(page).to have_link("Homepage")
      click_link "Homepage"

      within ("#form") do
        expect(page).to have_field("date", with: today_date)
      end
    end

    context "when click on see details button" do
      it "displays table information and change the date picker to the specific date" do
        visit '/'
        expect(page).to have_link("all sales")

        click_link "all sales"

        within all("#all-sales-table tbody tr").first do
          expect(page).to have_content('2023-10-22')
          expect(page).to have_button("see details")

          click_button "see details"
        end

        within ("#form") do
          expect(page).to have_field("date", with: '2023-10-22')
        end

        within ("#summary-table caption") do
          expect(page).to have_content('2023-10-22')
        end

        within all("#summary-table tbody tr").first do
          expect(page).to have_content('10.0')
          expect(page).to have_content('2.0')
          expect(page).to have_content('20.0')
        end

        within ("#summary-table tfoot tr") do
          expect(page).to have_content("Total")
          expect(page).to have_content("50.0")
          expect(page).to have_content("100.0")
        end
      end
    end
  end
end