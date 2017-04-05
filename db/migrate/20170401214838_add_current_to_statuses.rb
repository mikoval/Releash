class AddCurrentToStatuses < ActiveRecord::Migration
  def change
  	add_column :adopteds, :current_entry, :boolean, default: false
  	add_column :foster_statuses, :current_entry, :boolean, default: false
  	add_column :intakes, :current_entry, :boolean, default: false
  	add_column :other_statuses, :current_entry, :boolean, default: false
  	add_column :trainings, :current_entry, :boolean, default: false
  	add_column :vettings, :current_entry, :boolean, default: false
  end
end
