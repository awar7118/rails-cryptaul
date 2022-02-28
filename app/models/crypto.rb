class Crypto < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  has_many :purchases
  has_many :watchlists
  has_many :order_products
end
