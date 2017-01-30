class AddPrimaryBreeds < ActiveRecord::Migration
  	def change
	    change_table :animals do |t|
	      t.references :primary_breed
      	  t.references :secondary_breed
    end
   	def down
    	remove_column :animals, :breed_id
  	end
  end
end
