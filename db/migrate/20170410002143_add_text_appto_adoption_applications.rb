class AddTextApptoAdoptionApplications < ActiveRecord::Migration
  def change
  	add_column :animal_applications, :text_app, :string
  end
end
