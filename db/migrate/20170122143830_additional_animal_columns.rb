class AdditionalAnimalColumns < ActiveRecord::Migration
  def change
    add_column :animals, :eye_color, :string
    add_column :animals, :adoption_fee, :string
    add_column :animals, :animal_type, :string
    add_column :animals, :birthday, :string
    add_column :animals, :gender, :string
    add_column :animals, :cage_number, :integer
    add_column :animals, :microchip_number, :integer
    add_column :animals, :tag_number, :integer
    add_column :animals, :neutered, :integer

  end
end
