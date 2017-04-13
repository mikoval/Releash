class AddAnimalColms < ActiveRecord::Migration
  def change

    add_reference :animals, :status
  end
end
