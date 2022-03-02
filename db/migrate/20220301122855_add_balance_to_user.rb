class AddBalanceToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :balance, :float, default: 100
  end
end
