class DropMiscColumns < ActiveRecord::Migration
  def up
  	remove_column :status_types, :created_at, :updated_at
  	remove_column :hold_types, :created_at, :updated_at
  end
  def down
    add_column :intakes, :intake_stat, :references
    add_column :intakes, :intake_hold, :references
  end
end
