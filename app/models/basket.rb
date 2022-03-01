class Basket < ApplicationRecord
  belongs_to :user
  has_many :order_products, dependent: :destroy
  validates :total_price, presence: true
end
