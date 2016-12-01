class AddDocumentsToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :documents, :string
  end
end
