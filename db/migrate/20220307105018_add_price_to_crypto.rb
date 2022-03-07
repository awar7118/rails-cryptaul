class AddPriceToCrypto < ActiveRecord::Migration[6.1]
  def change
    add_column :cryptos, :price, :float
  end
end
