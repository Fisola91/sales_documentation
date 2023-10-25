class Order < ApplicationRecord
  scope :created_on, ->(date) {
    where("DATE(created_at) = ?", date)
  }
end
