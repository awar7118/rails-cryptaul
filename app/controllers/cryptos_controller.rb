class CryptosController < ApplicationController
  before_action :find_crypto, only: :show
  def index
    @cryptos = Crypto.all
  end

  def show
    @holding = Holding.new
  end

  private

  def find_crypto
    @crypto = Crypto.find(params[:id])
  end
end
