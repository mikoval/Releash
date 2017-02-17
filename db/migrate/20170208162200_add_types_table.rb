class AddTypesTable < ActiveRecord::Migration
  def change
    create_table :alert_types do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
