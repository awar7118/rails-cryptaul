class HoldingsController < ApplicationController
  def index
  end
  
  def create # BUY
    @holding = Holding.new(holding_params)
    @crypto = Crypto.find(params[:crypto_id])
    @holding.crypto = @crypto
    @holding.user = current_user
    @price = @crypto.histories.last.price # find_by(date: @holding.purchased_date).price
    @holding.purchased_price = @price
    @date = Time.now
    @holding.purchased_date = @date

    if @holding.save!
      current_user.update(balance: current_user.balance - (@price * @holding.quantity))
      redirect_to my_dashboard_path
    else
      render 'cryptos/show'
    end
  end

  def update # SELL
    current_user.update(balance: current_user.balance + params[:amount])
  end

  private

  def holding_params
    params.require(:holding).permit(:quantity)
  end
end
