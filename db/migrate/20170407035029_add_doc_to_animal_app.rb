class AddDocToAnimalApp < ActiveRecord::Migration
  def change
  	add_column :animal_applications, :adoption_document, :string
  	add_column :users, :user_document, :string
  	add_column :non_users, :nonuser_document, :string
  end
end
