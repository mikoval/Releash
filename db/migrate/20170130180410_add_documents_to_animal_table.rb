class AddDocumentsToAnimalTable < ActiveRecord::Migration
  def change
    add_column :animals, :intake_document, :string
    add_column :animals, :owner_surrender_document, :string
    add_column :animals, :home_check_document, :string
    add_column :animals, :match_application_document, :string
    add_column :animals, :adoption_application_document, :string
    add_column :animals, :adoption_contract_document, :string
    add_column :animals, :vetting_document, :string
  end

end
