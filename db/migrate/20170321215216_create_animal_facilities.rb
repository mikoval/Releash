class CreateAnimalFacilities < ActiveRecord::Migration
  def change
    create_table :animal_facilities do |t|
    	t.string :name
    	t.string :address
    	t.string :state
    	t.integer :zip_code
    	t.string :email
    end
  end
end
