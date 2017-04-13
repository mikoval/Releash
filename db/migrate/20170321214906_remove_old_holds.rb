class RemoveOldHolds < ActiveRecord::Migration
  def up
  	remove_column :intakes, :intake_hold_id
  	remove_column :status_types, :updated_at
  	remove_column :vettings, :vet_hold_id
  end
end
