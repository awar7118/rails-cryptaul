class AddOver18ToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :over18, :boolean
  end
end
