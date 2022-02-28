class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :crypto
  validates :quantity, presence: true
  validates :purchased_price, presence: true
end
