class AddCoordinatesToSeatingPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :seating_plans, :latitude, :float
    add_column :seating_plans, :longitude, :float
  end
end
