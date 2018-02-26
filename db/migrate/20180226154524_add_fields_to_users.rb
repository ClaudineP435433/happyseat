class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :groom_first_name, :string
    add_column :users, :groom_last_name, :string
    add_column :users, :bride_first_name, :string
    add_column :users, :bride_last_name, :string
    add_column :users, :address, :string
  end
end
