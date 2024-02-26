# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"

User.delete_all

fisola = User.create!(username: "fisola", email: "fisola@gmail.com", password: "123456")
vic = User.create!(username: "vic", email: "vic@gmail.com", password: "123456")
emmy = User.create!(username: "emmy", email: "emmy@gmail.com", password: "123456")


# p User.all
User.all.each do |user|
  5.times do
    quantity = Faker::Number.decimal(r_digits: 1).to_f
    unit_price = Faker::Number.decimal(r_digits: 1).to_f
    total = quantity * unit_price

    user.orders.create!(
      name: Faker::Commerce.unique.product_name,
      quantity: Faker::Number.decimal(r_digits: 1),
      unit_price: Faker::Number.decimal(r_digits: 1),
      total: total,
      date: Date.today.strftime("%Y-%m-%d")
    )
  end
end