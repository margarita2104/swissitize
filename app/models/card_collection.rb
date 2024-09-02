class CardCollection < ApplicationRecord
  has_many :cards

  validates :name, presence: true
  validates :description, presence: true
end
