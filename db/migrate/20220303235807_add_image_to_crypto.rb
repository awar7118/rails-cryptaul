class AddImageToCrypto < ActiveRecord::Migration[6.1]
  def change
    add_column :cryptos, :image, :string
  end
end
