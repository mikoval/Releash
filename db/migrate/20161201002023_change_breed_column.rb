class ChangeBreedColumn < ActiveRecord::Migration
  def change
    remove_column :animals, :breed
    add_column :animals, :breed_id, :integer, :default => 1
  end
end
