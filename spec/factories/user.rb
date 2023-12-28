FactoryBot.define do
  factory :user do
    username { "John" }
    email { "john@gmail.com" }
    password { "123456" }
  end
end