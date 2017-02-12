class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :type
      t.timestamps null: false
    end
  end
end
