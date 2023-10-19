require 'rails_helper'

RSpec.describe 'Order management', type: :system do
  before do
    visit '/'
  end

  it 'displays the initial state of the page' do
    expect(page).to have_css('table.hidden', visible: false)
    expect(find_field('name').value).to be_empty
    expect(find_field('quantity').value).to be_empty
    expect(find_field('unit_price').value).to be_empty
    expect(find_field('total').value).to be_empty
  end
  context "when form input and submission" do
    it 'calculates the total and total sum row' do
      fill_in 'name', with: 'Product A'
      fill_in 'quantity', with: 10
      fill_in 'unit_price', with: 2
      find('#unit_price').send_keys(:tab)
      expect(page).to have_field('total', with: '20.00')
      
      click_button "Save"
    
      expect(find_field('name').value).to be_empty
      expect(find_field('quantity').value).to be_empty
      expect(find_field('unit_price').value).to be_empty
      expect(find_field('total').value).to be_empty
      
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
      fill_in 'name', with: 'Product A'
      fill_in 'quantity', with: 10
      fill_in 'unit_price', with: 2
      find('#unit_price').send_keys(:tab)
      expect(page).to have_field('total', with: '20.00')
      
      click_button "Save"
      
      within ("#summary-table tbody") do
        expect(page).to have_content("Product A")
        expect(page).to have_content("10.0")
        expect(page).to have_content("2.0")
        expect(page).to have_content("20.0")
        expect(page).to have_link("edit")
        expect(page).to have_link("delete")
      end

      fill_in 'name', with: 'Product B'
      fill_in 'quantity', with: 10
      fill_in 'unit_price', with: 3
      find('#unit_price').send_keys(:tab)
      expect(page).to have_field('total', with: '30.00')
      
      click_button "Save"
      
      within all("#summary-table tbody").first do
        expect(page).to have_content("Product A")
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

    it "can edit and update order information" do
      fill_in 'name', with: 'Product A'
      fill_in 'quantity', with: 10
      fill_in 'unit_price', with: 2
      find('#unit_price').send_keys(:tab)
      expect(page).to have_field('total', with: '20.00')
      
      click_button "Save"
      
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

      within ("#summary-table tbody") do
        click_link "edit"
      end

      expect(find_field('name').value).to eq("Product A")
      expect(find_field('quantity').value).to eq("10.0")
      expect(find_field('unit_price').value).to eq("2.0")
      expect(find_field('total').value).to eq("20.0")

      fill_in 'name', with: 'Product B'
      
      click_button "Update"

      within ("#summary-table tbody") do
        expect(page).to have_content("Product B")
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

    it "resets the form" do
      fill_in 'name', with: 'Product A'
      fill_in 'quantity', with: 10
      fill_in 'unit_price', with: 3
      find('#unit_price').send_keys(:tab)
      expect(page).to have_field('total', with: '30.00')
      
      click_button "Save"

      expect(find_field('name').value).to be_empty
      expect(find_field('quantity').value).to be_empty
      expect(find_field('unit_price').value).to be_empty
      expect(find_field('total').value).to be_empty
    end
  end
end
