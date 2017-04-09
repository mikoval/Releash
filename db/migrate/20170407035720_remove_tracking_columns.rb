class RemoveTrackingColumns < ActiveRecord::Migration
  def change
  	remove_column :vettings, :curr_fost_id
  	remove_column :trainings, :expense
  	
  	remove_column :intakes, :foster_id
  	remove_column :intakes, :vet_id
  	add_reference :intakes, :intake_reason

  	remove_column :foster_statuses, :adopter_id
  	remove_column :foster_statuses, :vet_id
  	remove_column :foster_statuses, :homecheck

  	drop_table :sub_statuses
  	drop_table :other_statuses
  	drop_table :marketings
  	drop_table :hold_types

  end
end
