class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Add in email presence and format validation or already part of devise?
  before_create :set_simulation_date
  has_many :holdings, dependent: :destroy
  has_many :watchlists, dependent: :destroy
  has_many :cryptos, through: :holdings

  def set_simulation_date
    self.simulation_date = Time.at(1614816000)
  end
end
