class HoldingsController < ApplicationController
  def index
    @holdings = Holding.where(user: current_user)

    @holdings_value = @holdings.sum do |holding|
      holding.crypto.histories.find_by(date: current_user.simulation_date).price
    end

    @history_data = []
    @simulation_start = Time.at(1_614_816_000)
    date = @simulation_start
    until date > current_user.simulation_date
      @history_data << [date, sum_on_date(date)]
      date += 86_400
    end
  end

  def create # BUY
    @holding = Holding.new(holding_params)
    @crypto = Crypto.find(params[:crypto_id])
    @holding.crypto = @crypto
    @holding.user = current_user
    @date = current_user.simulation_date
    @price = @crypto.histories.find_by(date: current_user.simulation_date).price
    @holding.purchased_price = @price
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

  def advance_date
    puts 'advancing date..'
    current_user.simulation_date = current_user.simulation_date.advance(days: 1)
    current_user.save
    redirect_to my_dashboard_path
  end

  def sum_on_date(date)

    holding_value = @holdings.sum do |holding|
      holding.crypto.histories.find_by(date: date).price
    end
    balance_value = 3
    balance_value - holding_value
  end

  private

  def holding_params
    params.require(:holding).permit(:quantity)
  end
end
