FactoryBot.define do
    factory :order do
      name { Faker::Commerce.product_name }
      quantity { Faker::Number.decimal(l_digits: 2) }
      unit_price { Faker::Number.decimal(l_digits: 2) }
      total { quantity.to_f * unit_price.to_f }
    end
  end