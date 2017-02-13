class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
        t.string :title
        t.string :description
        t.datetime :date
        t.references :alert_type
        t.references :assignee, array: true, default: []
        t.references :created_by
        t.references :animal, array: true, default: []
        t.string :location
        t.timestamps null: false
    end
  end
end
