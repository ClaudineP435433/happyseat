class CreateSeatingPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :seating_plans do |t|
      t.string :name
      t.integer :nb_participants
      t.string :wedding_address
      t.date :wedding_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
