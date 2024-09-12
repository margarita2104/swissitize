class CardCollection < ApplicationRecord
  has_many :cards, dependent: :destroy
  accepts_nested_attributes_for :cards, allow_destroy: true, reject_if: :all_blank
  validates :name, presence: true
end
