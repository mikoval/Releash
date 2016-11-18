class UpdateUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :int
  end
end
