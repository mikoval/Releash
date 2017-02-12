class CreateAlertsTable < ActiveRecord::Migration
  def change
  	drop_table :alerts
  	create_table :alerts do |t|
      t.string :title
      t.string :description
      t.datetime :date
      t.string :type
      t.references :assignee, array: true, default: []
      t.references :created_by
      t.references :animal, array: true, default: []
      t.string :location
      t.timestamps null: false
    end
  end
end
