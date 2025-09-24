class AddProfileFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :business_name, :string
    add_column :users, :business_address, :text
    add_column :users, :phone, :string
    add_column :users, :role, :string
  end
end
