class AddNewAnimalColInputDate < ActiveRecord::Migration
  def change
  	add_column :animals, :input_date, :string
  	add_column :animals, :date_death, :string
  	add_column :animals, :date_adopted, :string
  	add_column :animals, :vetting_completed, :boolean, default: false
  	add_reference :animals, :coordinator
  	rename_column :animals, :visibility, :inactive_animal
  end
end
