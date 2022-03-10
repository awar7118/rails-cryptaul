class HoldingsController < ApplicationController
  # before_action :graph_prices, only: :index

  def index
    @holdings = Holding.where(user: current_user)
    @active_holdings = []
    @sold_holdings = []
    @holdings.each do |holding|
      if current_user.simulation_date >= holding.purchased_date && (holding.sold_date == nil || current_user.simulation_date < holding.sold_date)
        @active_holdings << holding
      elsif current_user.simulation_date >= holding.purchased_date && (holding.sold_date != nil || current_user.simulation_date >= holding.sold_date)
        @sold_holdings << holding
      end
    end

    # 24 hour percentage change
    @holdings.each do |holding|
      if holding.crypto.histories.find_by(date: current_user.simulation_date)
        price_today = holding.crypto.histories.find_by(date: current_user.simulation_date).price
        yesterday = current_user.simulation_date - 86_400
        if holding.crypto.histories.find_by(date: yesterday).nil?
          holding.crypto.previousdaypercentagechange = 0
        else
          price_yesterday = holding.crypto.histories.find_by(date: yesterday).price
          holding.crypto.price = price_today
          holding.crypto.previousdaypercentagechange = ((price_today - price_yesterday) / price_yesterday) * 100
        end
      end
      holding.crypto.save
    end



    if current_user.holdings.exists?
      start_date = Date.parse(@holdings.select(:purchased_date).to_a.min.purchased_date.strftime('%d/%m/%Y'))
    else
      start_date = Date.parse(Time.at(1614816000).strftime('%d/%m/%Y'))
    end
    end_date = Date.parse(current_user.simulation_date.strftime('%d/%m/%Y'))
    date_range = (start_date..end_date).to_a

    @holding_record = []

    # Data for the graph - active holdings
    date_range.each do |date|
      holdings_value = @holdings.sum do |holding|
        if date >= holding.purchased_date && (holding.sold_date == nil || date < holding.sold_date)
          holding.crypto.histories.find_by(date: date).price * holding.quantity
        else
          0
        end
      end
      @holding_record << [date, holdings_value]
    end
    #  Data for the active holdings card
    @active_holdings_value = @active_holdings.sum do |holding|
      holding.crypto.histories.find_by(date: current_user.simulation_date).price * holding.quantity
    end

    # Data for the sold holdings card
    @sold_holdings_value = @sold_holdings.sum do |holding|
      holding.crypto.histories.find_by(date: holding.sold_date).price * holding.quantity
    end
  end

  def create # BUY
    @holding = Holding.new(holding_params)
    @crypto = Crypto.find(params[:crypto_id])
    @holding.crypto = @crypto
    @holding.user = current_user
    @date = current_user.simulation_date
    @price = @crypto.histories.find_by(date: current_user.simulation_date).price * @holding.quantity
    @holding.purchased_price = @price
    @holding.purchased_date = @date
    if current_user.balance >= @price
      if @holding.save!
        current_user.update(balance: current_user.balance - @price)
        redirect_to my_dashboard_path
      else
        render 'cryptos/show'
      end
    else
      render 'cryptos/show'
    end
  end

  def update # SELL
    @holding = Holding.find(params[:id])
    @price = @holding.crypto.histories.find_by(date: current_user.simulation_date).price * @holding.quantity
    @holding.sold_price = @price
    @holding.sold_date = current_user.simulation_date
    if @holding.save
      current_user.update(balance: current_user.balance + @price)
      redirect_to my_dashboard_path
    else
      render 'my_dashboard'
    end
  end

  def advance_date
    puts 'advancing date..'
    current_user.simulation_date = current_user.simulation_date.advance(days: 1)
    current_user.save
    redirect_to(request.referrer)
  end

  def advance_date_week
    puts 'advancing date..'
    current_user.simulation_date = current_user.simulation_date.advance(weeks: 1)
    current_user.save
    redirect_to(request.referrer)
  end

  def reset_holdings
    current_user.set_simulation_date
    current_user.balance = 100
    current_user.holdings.destroy_all
    current_user.save
    current_user.watchlists.destroy_all
    redirect_to my_dashboard_path
  end

  private

  def holding_params
    params.require(:holding).permit(:quantity)
  end
end
