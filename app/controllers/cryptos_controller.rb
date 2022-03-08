class CryptosController < ApplicationController
  require 'json'

  before_action :find_crypto, only: :show
  def index
    @watchlist = Watchlist.new
    @cryptos = Crypto.all
    @cryptos.each do |crypto|
      if crypto.histories.find_by(date: current_user.simulation_date)
        crypto.price = crypto.histories.find_by(date: current_user.simulation_date).price
      end
      crypto.save
    end
    @cryptos = @cryptos.sort_by { |crypto| crypto.id.to_i }
  end

  def show
    @holding = Holding.new
    @watchlist = Watchlist.new
  end

  private

  def find_crypto
    @crypto = Crypto.find(params[:id])
    current_date = current_user.simulation_date
    @price_data = @crypto.histories.where('date <= ?', current_date).map do |price|
      [price.date, price.price]
    end
    p @price_data
  end
end
