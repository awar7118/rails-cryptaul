class CryptosController < ApplicationController
  require 'json'

  before_action :find_crypto, only: :show
  def index
    @cryptos = Crypto.all
  end

  def show
  end

  private

  def find_crypto
    @crypto = Crypto.find(params[:id])
    @price_data = @crypto.histories.map do |price|
      [price.date, price.price]
    end
    p @price_data
  end
end
