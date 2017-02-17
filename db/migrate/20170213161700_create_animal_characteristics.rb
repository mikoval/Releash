class CreateAnimalCharacteristics < ActiveRecord::Migration
  def change
    create_table :animal_characteristics do |t|
      t.integer :animal_id
      t.integer :characteristic_id

      t.timestamps null: false
    end
  end
end
