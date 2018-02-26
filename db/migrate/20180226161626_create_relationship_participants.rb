class CreateRelationshipParticipants < ActiveRecord::Migration[5.1]
  def change
    create_table :relationship_participants do |t|
      t.references :participant, foreign_key: true
      t.references :relationship, foreign_key: true

      t.timestamps
    end
  end
end
