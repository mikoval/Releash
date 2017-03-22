class DropMiscTables < ActiveRecord::Migration
  def up
  	drop_table :hold_types
  	drop_table :illnesses
  	drop_table :other_holds
  end
end
