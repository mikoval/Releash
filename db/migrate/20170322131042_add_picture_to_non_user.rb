class AddPictureToNonUser < ActiveRecord::Migration
  def change
  	add_column :non_users, :picture, :string
  end
end
