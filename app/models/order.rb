class Order < ApplicationRecord
  belongs_to :user
  scope :created_on, ->(date) {
    where("DATE(date) = ?", date)
  }
end
