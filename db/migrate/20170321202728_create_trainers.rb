class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
    	t.string :name
    	t.string :address
    	t.string :state
    	t.integer :zip_code
    	t.string :email
    end
  end
end