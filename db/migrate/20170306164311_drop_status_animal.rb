class DropStatusAnimal < ActiveRecord::Migration
  def up
  	remove_column :animals, :status
  end
end

