class User < ApplicationRecord
  has_many :credentials
  validates :username, presence: true, uniqueness: true
end
