class UpdateAlertReferences < ActiveRecord::Migration
  def change
  	change_column :alerts, :type, :integer
  end
end
