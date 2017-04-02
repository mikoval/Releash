class AddRequiredToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :required, :boolean, default: false
    add_column :alerts, :completed, :boolean, default: false
  end
end
