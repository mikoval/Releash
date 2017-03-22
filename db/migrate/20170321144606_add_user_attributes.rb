class AddUserAttributes < ActiveRecord::Migration
  def change
  	add_column :users, :address, :string
  	add_column :users, :state, :string
  	add_column :users, :zip_code, :integer
    add_column :users, :foster_check, :boolean, default: false
    add_column :users, :adopt_check, :boolean, default: false
  end
end
