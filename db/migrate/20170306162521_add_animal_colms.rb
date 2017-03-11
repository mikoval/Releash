class AddAnimalColms < ActiveRecord::Migration
  def change
  	add_reference :adopteds, :animal
    add_reference :ani_sleeps, :animal
    add_reference :ani_transfers, :animal
    
    add_reference :foster_stages, :animal
    add_reference :illnesses, :animal
    add_reference :intakes, :animal
    add_reference :other_holds, :animal

    add_reference :trainings, :animal
    add_reference :vettings, :animal
    add_reference :animals, :status
  end
end
