class RemoveWeddingAddressFromSeatingPlans < ActiveRecord::Migration[5.1]
  def change
    rename_column :seating_plans, :wedding_address, :address
  end
end
