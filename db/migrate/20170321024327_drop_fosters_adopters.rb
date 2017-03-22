class DropFostersAdopters < ActiveRecord::Migration
  def change
  	drop_table :adopters
  	drop_table :foster_stages
  	drop_table :fosters
  end
end
