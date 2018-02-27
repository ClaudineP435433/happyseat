class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :link
      t.references :first_guest
      t.references :second_guest

      t.timestamps
    end
  end
end
