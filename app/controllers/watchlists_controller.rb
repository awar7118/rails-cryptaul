class WatchlistsController < ApplicationController
  def index
    @watchlists = Watchlist.all
  end

  def create
    @watchlist = Watchlist.new
    @crypto = Crypto.find(params[:crypto_id])
    @watchlist.user = current_user
    @watchlist.crypto = @crypto

  
    if @watchlist.save!
      redirect_to crypto_path(@crypto)
    else
      render 'cryptos/show'
    end
  end

  def destroy #remove watchlist
  end

  private

end
