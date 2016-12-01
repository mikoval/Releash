class ChangeSpeciesColumn < ActiveRecord::Migration
  def change
    remove_column :animals, :species
    add_column :animals, :species_id, :integer
  end
end
