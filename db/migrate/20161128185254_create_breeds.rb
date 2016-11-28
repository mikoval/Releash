class CreateBreeds < ActiveRecord::Migration
  def change
    create_table :breeds do |t|
      t.string :name
      t.integer :species_id

      t.timestamps null: false
    end
  end
end
