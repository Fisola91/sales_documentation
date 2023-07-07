require "rails_helper"

RSpec.describe "signed merchant can navigate through different pages" do
    before do
        visit "/"
    end

    it "displays the initial state of the page" do
        expect(page).to have_text("Recent sales")
        expect(page).to have_link("Enter sales")
        expect(page).to have_link("see more")

        within 'table[data-order-target="summaryTable"] thead tr' do
            expect(page).to have_content("Date")
            expect(page).to have_content("Earnings")
            expect(page).to have_content("Total amount")
            expect(page).to have_content("see details")
        end

        within 'table[data-order-target="summaryTable"] .line-items' do
            expect(find_field("name").value) be_empty
            expect(find_field("quantity").value) be_empty
            expect(find_field("unit_price").value) be_empty
            expect(find_field("total").value) be_empty
        end
    end

    it "can calculates the total based on form input" do
        expect(page).to have_text("Recent sales")
        expect(page).to have_link("Enter sales")
        expect(page).to have_link("see more")

        click "Enter sales"

        fill_in "name", with: "Product A"
        fill_in "quantity", with: 10
        fill_in "unit_price", with: 100
        find('#unit_price').send_keys(:tab)

        expect(page).to have_field("total", with: "1000")
    end

    it "creates a 'Total' sums row" do
        expect(page).to have_text("Recent sales")
        expect(page).to have_link("Enter sales")
        expect(page).to have_link("see more")

        click "Enter sales"

        fill_in "name", with: "Product A"
        fill_in "quantity", with: 10
        fill_in "unit_price", with: 100
        click_button "Save"

        expect(page).to have_text("Recent sales")
        expect(page).to have_link("Enter sales")

        within all('table[data-order-target="summaryTable"] .line-item').first do
            expect(page).to have_content("Product A")
            expect(page).to have_content("10")
            expect(page).to have_content("100")
            expect(page).to have_content("1000")
        end

        click "Enter sales"

        fill_in "name", with: "Product B"
        fill_in "quantity", with: 20
        fill_in "unit_price", with: 100
        click_button "Save"

        within all('table[data-order-target="summaryTable"] .line-item').first do
            expect(page).to have_content("Product A")
            expect(page).to have_content("10")
            expect(page).to have_content("100")
            expect(page).to have_content("1000")
        end
        within all('table[data-order-target="summaryTable"] .line-item').last do
            expect(page).to have_content("Product B")
            expect(page).to have_content("10")
            expect(page).to have_content("200")
            expect(page).to have_content("2000")
        end
        within 'table[data-order-target="summaryTable"] tr.sums-row' do
            expect(page).to have_content('Total')
            expect(page).to have_content('20')
            expect(page).to have_content('3000')
        end
    end
end