require 'rails_helper'

RSpec.describe "Sales per day", type: :system do
  let(:user) { create(:user) }

  let!(:order) {
    [
      create_list(:order, 5, date: '2023-10-22'),
      create_list(:order, 5, date: '2023-10-23'),
      create_list(:order, 5, date: '2023-10-24'),
      create_list(:order, 5, date: '2023-10-25')
    ].flatten
  }

  let(:today_date) { Date.today }

  before do
    login_as user
  end


  it "displays page table headings" do
    visit orders_path
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
      visit orders_path
      expect(page).to have_link("all sales")

      click_link "all sales"
      expect(page).to have_content("ALL SALES PER DAY")
      expect(page).to have_link("Dashboard")

      within ("#all-sales-table tbody") do
        expect(page).to have_content('2023-10-22')
        expect(page).to have_content('100.0')
        expect(page).to have_content('2023-10-24')
        expect(page).to have_content('100.0')
        expect(page).to have_content('2023-10-25')
        expect(page).to have_content('100.0')
      end
    end

    it "shows ground total for the sum rows for different dates" do
      visit orders_path
      expect(page).to have_link("all sales")

      click_link "all sales"
      expect(page).to have_content("ALL SALES PER DAY")
      expect(page).to have_link("Dashboard")

      within ("#all-sales-table tbody") do
        expect(page).to have_content('2023-10-24')
        expect(page).to have_content('100.0')
      end

      within ("#all-sales-table tfoot") do
        expect(page).to have_content('Total')
        expect(page).to have_content('400.0')
      end
    end

    it "returns back to the dashboard" do
      visit dashboard_index_path
      expect(page).to have_link("all sales")

      click_link "all sales"
      expect(page).to have_content("ALL SALES PER DAY")
      expect(page).to have_link("Dashboard")
      click_link "Dashboard"

      expect(find("#all-sales-table tbody")).to have_css("tr", count: 4)
    end

    context "when click on see details button" do
      it "displays table information and change the date picker to the specific date" do
        visit dashboard_index_path
        expect(page).to have_link("all sales")

        click_link "all sales"

        within ('tbody') do
          within('tr', text: '2023-10-25') do
            click_button 'see details'
          end
        end

        within ("#form") do
          expect(page).to have_field("date", with: '2023-10-25')
        end

        within ("#summary-table caption") do
          expect(page).to have_content('2023-10-25')
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

  it "searches all sales by date range" do
    visit orders_path

    expect(page).to have_link("all sales")

    click_link "all sales"

    fill_in "date_range", with: "2023-10-23 - 2023-10-25"

    click_on "Select date"

    expect(find_field('date_range').value).to eq("2023-10-23 - 2023-10-25")

    within all("#all-sales-table tbody tr").first do
      expect(page).to have_content('2023-10-23', wait: 5)
      expect(page).to have_button("see details")
    end

    within all("#all-sales-table tbody tr")[1] do
      expect(page).to have_content('2023-10-24', wait: 5)
      expect(page).to have_button("see details")
    end

    within all("#all-sales-table tbody tr").last do
      expect(page).to have_content('2023-10-25', wait: 5)
      expect(page).to have_button("see details")
    end

    within all("#all-sales-table tbody tr").first do
      expect(page).to_not have_content('2023-10-22', wait: 5)
    end
  end
end