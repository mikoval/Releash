class AddCityToUserNonUser < ActiveRecord::Migration
  def change
  	add_column :users, :city, :string
  	add_column :non_users, :city, :string
  end
end
