class AddPictureToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :picture, :string
  end
end
