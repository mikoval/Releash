class DropVets < ActiveRecord::Migration
  def up
  	drop_table :veterinarians
  end
end
