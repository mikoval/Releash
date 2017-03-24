class AddRequiredToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :required, :bool, default: false
    add_column :alerts, :completed, :bool, default: false
  end
end
