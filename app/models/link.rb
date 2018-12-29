class Link < ApplicationRecord
  belongs_to :user
  has_many :votes

  validates :url, uniqueness: true, presence: true
end
