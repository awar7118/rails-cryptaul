class ChangeHoldingsQuantityToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :holdings, :quantity, :float
  end
end
