class History < ApplicationRecord
  belongs_to :crypto
  validates :date, presence: true
  validates :price, presence: true
end
