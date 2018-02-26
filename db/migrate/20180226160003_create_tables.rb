class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :nb_max_participants
      t.references :seating_plan, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
