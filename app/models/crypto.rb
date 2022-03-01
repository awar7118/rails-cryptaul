class Crypto < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :abbreviation, presence: true
  has_many :purchases
  has_many :watchlists
  has_many :order_products
  has_many :histories
end
