class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.datetime :date
      t.float :price
      t.references :crypto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
