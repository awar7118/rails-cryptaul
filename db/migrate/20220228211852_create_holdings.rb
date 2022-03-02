class CreateHoldings < ActiveRecord::Migration[6.1]
  def change
    create_table :holdings do |t|
      t.float :purchased_price
      t.datetime :purchased_date
      t.float :sold_price
      t.datetime :sold_date
      t.integer :quantity
      t.references :user, null: false, foreign_key: true
      t.references :crypto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
