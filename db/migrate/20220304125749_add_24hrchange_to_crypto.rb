class Add24hrchangeToCrypto < ActiveRecord::Migration[6.1]
  def change
    add_column :cryptos, :previousdaypercentagechange, :float
  end
end
