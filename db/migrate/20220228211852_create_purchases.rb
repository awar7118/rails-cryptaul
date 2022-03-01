class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.float :purchased_price
      t.integer :quantity
      t.references :user, null: false, foreign_key: true
      t.references :crypto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
