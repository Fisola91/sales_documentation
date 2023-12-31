require 'rails_helper'

RSpec.describe 'Order management', type: :system do
  let(:user) { create(:user) }
  let(:order) { create(:order) }

  before do
    login_as user

    visit orders_path

    @current_time = Time.local(2022, 12, 1, 10, 5, 0)
  end

  it 'displays the initial state of the page' do
    expect(page).to have_css('table.hidden', visible: false)
    expect(page).to have_field("Name", text: "")
    expect(page).to have_field("Quantity", text: "")
    expect(page).to have_field("Unit price", text: "")
    expect(page).to have_field("Total", text: "", disabled: true)
  end

  it "selects date and display order record for the selected date" do
    fill_in "date", with: order.date

    within ("#summary-table caption") do
      expect(page).to have_content("2022-12-01")
    end
  end

  context "when form input and submission" do
    it 'resets the form & calculates the total and total sum row for a specific date' do
      set_date element_id: "date", date: "2022-12-01"
      fill_in 'Name', with: 'Product A'
      fill_in 'Quantity', with: 10
      fill_in 'Unit price', with: 2
      find_field('Unit price').send_keys(:tab)
      expect(page).to have_field('Total', with: '20.00', disabled: true)

      Timecop.freeze(@current_time) do
        click_button "Save"
        expect(find("#summary-table tbody")).to have_css("tr", count: 1)
      end

      expect(page).to have_field("Name", text: "")
      expect(page).to have_field("Quantity", text: "")
      expect(page).to have_field("Unit price", text: "")
      expect(page).to have_field("Total", text: "", disabled: true)

      within ("#summary-table caption") do
        expect(page).to have_content("2022-12-01")
      end

      within ("#summary-table tbody tr") do
        expect(page).to have_content("Product A")
        expect(page).to have_content("10.0")
        expect(page).to have_content("2.0")
        expect(page).to have_content("20.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within ("#summary-table tfoot tr") do
        expect(page).to have_content("Total")
        expect(page).to have_content("10")
        expect(page).to have_content("20")
      end
    end

    it 'calculates the total and total sum rows for a specific' do
      set_date element_id: "date", date: "2022-12-01"
      fill_in 'Name', with: 'Product C'
      fill_in 'Quantity', with: 10
      fill_in 'Unit price', with: 2
      find_field('Unit price').send_keys(:tab)
      expect(page).to have_field('Total', with: '20.00', disabled: true)

      Timecop.freeze(@current_time) do
        click_button "Save"
        expect(find("#summary-table tbody")).to have_css("tr", count: 1)
      end

      within ("#summary-table caption") do
        expect(page).to have_content("2022-12-01")
      end

      within ("#summary-table tbody tr") do
        expect(page).to have_content("Product C")
        expect(page).to have_content("10.0")
        expect(page).to have_content("2.0")
        expect(page).to have_content("20.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      fill_in 'Name', with: 'Product B'
      fill_in 'Quantity', with: 10
      fill_in 'Unit price', with: 3
      find_field('Unit price').send_keys(:tab)
      expect(page).to have_field('Total', with: '30.00', disabled: true)

      click_button "Save"
      expect(find("#summary-table tbody")).to have_css("tr", count: 2)

      within ("#summary-table caption") do
        expect(page).to have_content("2022-12-01")
      end

      within all("#summary-table tbody tr").first do
        expect(page).to have_content("Product C")
        expect(page).to have_content("10.0")
        expect(page).to have_content("2.0")
        expect(page).to have_content("20.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within all("#summary-table tbody tr").last do
        expect(page).to have_content("Product B")
        expect(page).to have_content("10.0")
        expect(page).to have_content("3.0")
        expect(page).to have_content("30.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within ("#summary-table tfoot tr") do
        expect(page).to have_content("Total")
        expect(page).to have_content("20")
        expect(page).to have_content("50")
      end
    end

    it "edits and updates the product information for a specific date" do
      set_date element_id: "date", date: "2022-12-01"
      fill_in "Name", with: "Product A"
      fill_in "Quantity", with: 10
      fill_in "Unit price", with: 2
      find_field("Unit price").send_keys(:tab)
      expect(page).to have_field("Total", with: "20.00", disabled: true)

      Timecop.freeze(@current_time) do
        click_button "Save"

        within ("#summary-table tbody tr") do
          expect(page).to have_content("Product A")
          expect(page).to have_content("10.0")
          expect(page).to have_content("2.0")
          expect(page).to have_content("20.0")
          expect(page).to have_link("edit")
          expect(page).to have_link("delete")
        end

        within ("#summary-table tfoot tr") do
          expect(page).to have_content("Total")
          expect(page).to have_content("10.0")
          expect(page).to have_content("20.0")
        end

        within ("#summary-table tbody tr") do
          click_link "edit"
        end

        expect(page).to have_field("Name", with: "Product A")
        expect(page).to have_field("Quantity", with: "10.0")
        expect(page).to have_field("Unit price", with: "2.0")
        expect(page).to have_field("Total", with: "20.0", disabled: true)

        fill_in "Name", with: "Product C"
        fill_in "Unit price", with: 3
        find_field("Unit price").send_keys(:tab)
        expect(page).to have_field("Total", with: "30.00", disabled: true)

        click_button "Update"

        within ("#summary-table caption") do
          expect(page).to have_content("2022-12-01")
        end
      end

      within ("#summary-table tbody tr") do
        expect(page).to have_content("Product C")
        expect(page).to have_content("10.0")
        expect(page).to have_content("3.0")
        expect(page).to have_content("30.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within ("#summary-table tfoot tr") do
        expect(page).to have_content("Total")
        expect(page).to have_content("10.0")
        expect(page).to have_content("30.0")
      end
    end

    it "deletes an order record from the table for a specific date" do
      set_date element_id: "date", date: "2022-12-01"
      fill_in "Name", with: "Product A"
      fill_in "Quantity", with: 10
      fill_in "Unit price", with: 2
      find_field("Unit price").send_keys(:tab)
      expect(page).to have_field("Total", with: "20.00", disabled: true)

      Timecop.freeze(@current_time) do
        click_button "Save"

        within ("#summary-table tbody tr") do
          expect(page).to have_content("Product A")
          expect(page).to have_content("10.0")
          expect(page).to have_content("2.0")
          expect(page).to have_content("20.0")
          expect(page).to have_link("edit")
          expect(page).to have_link("delete")
        end

        within ("#summary-table tfoot tr") do
          expect(page).to have_content("Total")
          expect(page).to have_content("10.0")
          expect(page).to have_content("20.0")
        end

        within ("#summary-table tbody tr") do
          click_link "delete"
        end

        expect(page).to have_css('table.hidden', visible: false)
      end
    end

    it "displays only table information for a selected date" do
      set_date element_id: "date", date: "2022-12-01"
      fill_in 'Name', with: 'Product A'
      fill_in 'Quantity', with: 10
      fill_in 'Unit price', with: 2
      find_field('Unit price').send_keys(:tab)
      expect(page).to have_field('Total', with: '20.00', disabled: true)

      Timecop.freeze(@current_time) do
        click_button "Save"
        expect(find("#summary-table tbody")).to have_css("tr", count: 1)
      end

      within ("#summary-table caption") do
        expect(page).to have_content("2022-12-01")
      end

      within ("#summary-table tbody tr") do
        expect(page).to have_content("Product A")
        expect(page).to have_content("10.0")
        expect(page).to have_content("2.0")
        expect(page).to have_content("20.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within ("#summary-table tfoot tr") do
        expect(page).to have_content("Total")
        expect(page).to have_content("10")
        expect(page).to have_content("20")
      end

      set_date element_id: "date", date: "2022-12-02"
      fill_in 'Name', with: 'Product A'
      fill_in 'Quantity', with: 10
      fill_in 'Unit price', with: 2
      find_field('Unit price').send_keys(:tab)
      expect(page).to have_field('Total', with: '20.00', disabled: true)

      Timecop.freeze(@current_time) do
        click_button "Save"
        expect(find("#summary-table tbody")).to have_css("tr", count: 1)
      end
    end
  end
end
