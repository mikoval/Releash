class AddStatusToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :status, :string
  end
end
