class RemoveDocumentsFromAnimals < ActiveRecord::Migration
  def change
        remove_column :animals, :documents
  end
end
