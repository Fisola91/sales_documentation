FactoryBot.define do
    factory :order do
      sequence(:name) { |n| "Product #{n}" }
      quantity { 10.0 }
      unit_price { 2.0 }
      total { quantity.to_f * unit_price.to_f }
      date { "2022-12-01"}

      association :user, factory: :user
    end
  end