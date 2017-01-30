class RemoveOldBreedColumn < ActiveRecord::Migration
  def change
        remove_column :animals, :breed_id
  end
end
