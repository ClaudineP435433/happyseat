class AddPulseToParticipants < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :pulse, :boolean
  end
end
