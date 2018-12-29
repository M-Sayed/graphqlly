class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  validates :password, :password_confirmation, presence: true, on: :create

  has_many :votes
  has_many :links
end
