class AddVetsTable < ActiveRecord::Migration
  def change
	create_table :veterinarian do |t|
	  t.string :name
	  t.string :street
	  t.string :city
	  t.string :state
	  t.integer :zip_code
	end
  end
end
