class CreateParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.references :table, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :age_range
      t.integer :seat
      t.string :family_type

      t.timestamps
    end
  end
end
