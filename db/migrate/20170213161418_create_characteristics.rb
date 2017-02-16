class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.string :name
      t.string :category
      t.timestamps null: false
    end
  end
end
