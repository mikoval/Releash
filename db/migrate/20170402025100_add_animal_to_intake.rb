class AddAnimalToIntake < ActiveRecord::Migration
  def change
    add_reference :intakes, :animal
    add_reference :vettings, :animal
    add_reference :adopteds, :animal
    add_reference :trainings, :animal
  end
end
