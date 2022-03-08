class WatchlistsController < ApplicationController
  before_action :find_watchlist, only: :destroy

  def index
    @watchlists = Watchlist.where(user: current_user)
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
