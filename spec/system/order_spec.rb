require 'rails_helper'

RSpec.describe 'Order management', type: :system do
  before do
    visit '/'
  end

  it 'displays the initial state of the page' do
    expect(page).to have_css('table.hidden', visible: false)
    expect(page).to have_field("Name", text: "")
    expect(page).to have_field("Quantity", text: "")
    expect(page).to have_field("Unit price", text: "")
    expect(page).to have_field("Total", text: "", disabled: true)
  end

  context "when form input and submission" do
    it 'calculates the total and total sum row' do

      fill_in 'Name', with: 'Product A'
      fill_in 'Quantity', with: 10
      fill_in 'Unit price', with: 2
      find_field('Unit price').send_keys(:tab)
      expect(page).to have_field('Total', with: '20.00', disabled: true)
      
      click_button "Save"

      expect(page).to have_field("Name", text: "")
      expect(page).to have_field("Quantity", text: "")
      expect(page).to have_field("Unit price", text: "")
      expect(page).to have_field("Total", text: "", disabled: true)
      
      within ("#summary-table tbody") do
        expect(page).to have_content("Product A")
        expect(page).to have_content("10.0")
        expect(page).to have_content("2.0")
        expect(page).to have_content("20.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within ("#summary-table tfoot") do
        expect(page).to have_content("Total")
        expect(page).to have_content("10")
        expect(page).to have_content("20")
      end
    end

    it 'calculates the total and total sum rows' do
      fill_in 'Name', with: 'Product C'
      fill_in 'Quantity', with: 10
      fill_in 'Unit price', with: 2
      find_field('Unit price').send_keys(:tab)
      expect(page).to have_field('Total', with: '20.00', disabled: true)
      
      click_button "Save"
        
      within ("#summary-table tbody") do
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
      
      within all("#summary-table tbody").first do
        expect(page).to have_content("Product C")
        expect(page).to have_content("10.0")
        expect(page).to have_content("2.0")
        expect(page).to have_content("20.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within all("#summary-table tbody").last do
        expect(page).to have_content("Product B")
        expect(page).to have_content("10.0")
        expect(page).to have_content("3.0")
        expect(page).to have_content("30.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      within ("#summary-table tfoot") do
        expect(page).to have_content("Total")
        expect(page).to have_content("20")
        expect(page).to have_content("50")
      end
    end
  end
end
