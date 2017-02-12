class CreateAnimalBreeds < ActiveRecord::Migration
  def change
    drop_table :animal_breeds
    create_table :animal_breeds do |t|
      t.integer :animal_id
      t.integer :breed_id

      t.timestamps null: false
    end
  end
end
