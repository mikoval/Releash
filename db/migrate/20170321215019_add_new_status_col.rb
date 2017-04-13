class AddNewStatusCol < ActiveRecord::Migration
  def change
  	add_reference :adopteds, :sub_status
  	
  	add_reference :animals, :sub_status
  	add_reference :animals, :marketing

  	add_reference :intakes, :sub_status
  	add_reference :intakes, :animal_facility

  	add_reference :trainings, :trainer
  	add_reference :trainings, :sub_status

  	add_reference :vettings, :sub_status
  	add_column :users, :is_user, :boolean, default: false	
    #add_column :non_users, :is_non_user, :boolean, default: false 
  end
end
