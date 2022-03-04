class AddSimulationDateToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :simulation_date, :datetime
  end
end
