class AddColumnsToSeatinPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :seating_plans, :nb_tables, :integer
    add_column :seating_plans, :nb_max_participants, :integer
  end
end
