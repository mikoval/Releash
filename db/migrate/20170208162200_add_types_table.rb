class AddTypesTable < ActiveRecord::Migration
  def change
    create_table :alert_types do |t|
      t.string :type
      t.timestamps null: false
    end
  end
end
