class AddColumnToVets < ActiveRecord::Migration
  def change
  	add_column :veterinarian, :email, :string
  end
end
