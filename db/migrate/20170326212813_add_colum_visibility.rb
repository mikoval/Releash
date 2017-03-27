class AddColumVisibility < ActiveRecord::Migration
  def change
  	add_column :animals, :visibility, :boolean, default: false
  	rename_column :veterinarian, :street, :address
  end
end
