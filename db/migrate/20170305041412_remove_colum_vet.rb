class RemoveColumVet < ActiveRecord::Migration
  def up
  	remove_column :vettings, :intake_hold_id
  end
end
