class HoldingsController < ApplicationController
  # before_action :graph_prices, only: :index

  def index
    @holdings = Holding.where(user: current_user)
    @active_holdings = []
    @sold_holdings = []
    @holdings.each do |holding|
      if holding.sold_date.nil?
        @active_holdings << holding
      else
        @sold_holdings << holding
      end
    end

    if current_user.holdings.exists?
      start_date = Date.parse(@holdings.select(:purchased_date).to_a.min.purchased_date.strftime('%d/%m/%Y'))
    else
      start_date = Date.parse(Time.at(1614816000).strftime('%d/%m/%Y'))
    end
    end_date = Date.parse(current_user.simulation_date.strftime('%d/%m/%Y'))
    date_range = (start_date..end_date).to_a

    @holding_record = []

    date_range.each do |date|
      @holdings_value = @holdings.sum do |holding|
        if date >= holding.purchased_date
          holding.crypto.histories.find_by(date: date).price * holding.quantity
        else
          0
        end
      end
      @holding_record << [date, @holdings_value]
    end

    @holdings_value = @holdings.sum do |holding|
      holding.crypto.histories.find_by(date: current_user.simulation_date).price * holding.quantity
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

  # def advance_date_index
  #   puts 'advancing date..'
  #   current_user.simulation_date = current_user.simulation_date.advance(days: 1)
  #   current_user.save
  #   redirect_to cryptos_path
  # end

  # def advance_date_week_index
  #   puts 'advancing date..'
  #   current_user.simulation_date = current_user.simulation_date.advance(weeks: 1)
  #   current_user.save
  #   redirect_to cryptos_path
  # end

  # def advance_date_show
  #   puts 'advancing date..'
  #   current_user.simulation_date = current_user.simulation_date.advance(days: 1)
  #   current_user.save
  #   redirect_back(fallback_location: root_path)
  # end

  # def advance_date_week_show
  #   puts 'advancing date..'
  #   current_user.simulation_date = current_user.simulation_date.advance(weeks: 1)
  #   current_user.save
  #   redirect_back(fallback_location: root_path)
  # end

  private

  def holding_params
    params.require(:holding).permit(:quantity)
  end
end
