class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Add in email presence and format validation or already part of devise?
  has_many :holdings, dependent: :destroy
  has_many :watchlists, dependent: :destroy
  has_many :cryptos, through: :holdings
end
