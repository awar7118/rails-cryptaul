class WatchlistsController < ApplicationController
  before_action :find_watchlist, only: :destroy

  def index
    @watchlists = Watchlist.where(user: current_user)

    @watchlists.each do |watchlist|
      if watchlist.crypto.histories.find_by(date: current_user.simulation_date)
        price_today = watchlist.crypto.histories.find_by(date: current_user.simulation_date).price
        yesterday = current_user.simulation_date - 86_400
        if watchlist.crypto.histories.find_by(date: yesterday).nil?
          watchlist.crypto.previousdaypercentagechange = 0
        else
          price_yesterday = watchlist.crypto.histories.find_by(date: yesterday).price
          watchlist.crypto.price = price_today
          watchlist.crypto.previousdaypercentagechange = ((price_today - price_yesterday) / price_yesterday) * 100
        end
      end
      watchlist.crypto.save
    end
  end

  def create
    @watchlist = Watchlist.new
    @crypto = Crypto.find(params[:crypto_id])
    @watchlist.user = current_user
    @watchlist.crypto = @crypto

    if @watchlist.save!
      redirect_back(fallback_location: root_path)
    else
      render 'cryptos/show'
    end
  end

  def destroy
    @crypto = @watchlist.crypto
    @watchlist.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def find_watchlist
    @watchlist = Watchlist.find(params[:id])
  end
end
