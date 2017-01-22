class UpdateAnimalColumns < ActiveRecord::Migration
  def change
    add_column :animals, :color_primary, :string
    add_column :animals, :color_secondary, :string
    

  end
end
