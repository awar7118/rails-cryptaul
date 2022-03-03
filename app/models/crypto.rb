class Crypto < ApplicationRecord
  validates :name, presence: true
  validates :abbreviation, presence: true
  has_many :holdings
  has_many :watchlists
  has_many :histories, dependent: :destroy
end
