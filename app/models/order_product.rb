class OrderProduct < ApplicationRecord
  belongs_to :basket
  belongs_to :crypto
  validates :quantity, presence: true
  validates :fixed_price, presence: true
end
