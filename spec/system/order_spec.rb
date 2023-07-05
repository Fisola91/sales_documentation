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

  it 'calculates the total based on form input' do
    fill_in 'name', with: 'Product A'
    fill_in 'quantity', with: 10
    fill_in 'unit_price', with: 5.99
    find('#unit_price').send_keys(:tab)

    expect(page).to have_field('total', with: '59.90')
  end

  it 'creates a summary row upon form submission' do
    fill_in 'name', with: 'Product A'
    fill_in 'quantity', with: 10
    fill_in 'unit_price', with: 5.99

    click_button 'Save'

    within 'table[data-order-target="summaryTable"] .line-item' do
      expect(page).to have_content('Product A')
      expect(page).to have_content('10')
      expect(page).to have_content('5.99')
      expect(page).to have_content('59.90')
    end
  end

  it 'creates a "Total" sums row' do
    fill_in 'name', with: 'Product A'
    fill_in 'quantity', with: 10
    fill_in 'unit_price', with: 5.99
    click_button 'Save'

    fill_in 'name', with: 'Product B'
    fill_in 'quantity', with: 5
    fill_in 'unit_price', with: 8.5
    click_button 'Save'

    within all('table[data-order-target="summaryTable"] .line-item').first do
      expect(page).to have_content('Product A')
      expect(page).to have_content('10')
      expect(page).to have_content('5.99')
    end
    within all('table[data-order-target="summaryTable"] .line-item').last do
      expect(page).to have_content('Product B')
      expect(page).to have_content('5')
      expect(page).to have_content('8.50')
    end
    within 'table[data-order-target="summaryTable"] tr.sums-row' do
      expect(page).to have_content('Total')
      expect(page).to have_content('15')
      expect(page).to have_content('102.40')
    end
  end

  it 'resets the form after form submission' do
    fill_in 'name', with: 'Product A'
    fill_in 'quantity', with: 10
    fill_in 'unit_price', with: 5.99
    click_button 'Save'

    expect(find_field('name').value).to be_empty
    expect(find_field('quantity').value).to be_empty
    expect(find_field('unit_price').value).to be_empty
    expect(find_field('total').value).to be_empty
  end
end
