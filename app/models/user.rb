class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates :email, :encrypted_password, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          authentication_keys: [:username]
end
