class AddPhoneNumberUserNonUser < ActiveRecord::Migration
  def change
  	add_column :users, :phone_number, :string
  	add_column :non_users, :phone_number, :string
  end
end
