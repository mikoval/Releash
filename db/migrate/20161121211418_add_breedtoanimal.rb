class AddBreedtoanimal < ActiveRecord::Migration
  def change
    add_column :animals, :breed, :string
  end
end
