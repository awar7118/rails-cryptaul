class CryptosController < ApplicationController
  require 'json'

  before_action :find_crypto, only: :show
  def index
    @watchlist = Watchlist.new
    @cryptos = Crypto.all

    # 24 hour percentage change
    @cryptos.each do |crypto|
      if crypto.histories.find_by(date: current_user.simulation_date)
        price_today = crypto.histories.find_by(date: current_user.simulation_date).price
        yesterday = current_user.simulation_date - 86_400
        price_yesterday = crypto.histories.find_by(date: yesterday).price
        crypto.price = price_today
        crypto.previousdaypercentagechange = ((price_today - price_yesterday) / price_yesterday) * 100
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
