class AddHoldTypes < ActiveRecord::Migration
  def change
    create_table :hold_types do |t|
      t.string :name
      t.timestamps null: false
    end
    create_table :status_types do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end