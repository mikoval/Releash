class AddCityColumn < ActiveRecord::Migration
  def change
  	add_column :trainers, :city, :string
  	add_column :animal_facilities, :city, :string
  end
end
