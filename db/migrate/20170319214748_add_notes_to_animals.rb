class AddNotesToAnimals < ActiveRecord::Migration
  def change
     add_column :animals, :notes, :string
  end
end
