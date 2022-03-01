class RemovePriceFromCrypto < ActiveRecord::Migration[6.1]
  def change
    remove_column :cryptos, :price
  end
end
