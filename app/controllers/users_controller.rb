class UsersController < ApplicationController
  before_action :find_user, only: %i[show buy sell]

  def show
  end

  def buy
  end

  def sell
  end

  private

  def find_user
    @user = current_user
  end
end
