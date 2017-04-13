class CreateAnimalApplications < ActiveRecord::Migration
  def change
    create_table :animal_applications do |t|

      t.references :animal
      t.references :adopter
      t.string :comments
    end
  end
end
