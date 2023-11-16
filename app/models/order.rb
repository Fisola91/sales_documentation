class Order < ApplicationRecord
  scope :created_on, ->(date) {
    where("DATE(date) = ?", date)
  }
end
