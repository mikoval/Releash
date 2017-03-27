class AddOtherColumns < ActiveRecord::Migration
  def change
  	add_column :other_statuses, :status_name, :string
  end
end
