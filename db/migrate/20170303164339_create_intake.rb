class CreateIntake < ActiveRecord::Migration
  def change
    create_table :intakes do |t|
    	t.date :intake_date
    	t.references :foster
    	t.references :vet
    	t.string :comments
    end
  end
end
