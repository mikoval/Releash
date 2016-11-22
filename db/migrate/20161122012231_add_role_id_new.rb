class AddRoleIdNew < ActiveRecord::Migration
  def change
    add_column :users, :role_id, :int
  end
end
