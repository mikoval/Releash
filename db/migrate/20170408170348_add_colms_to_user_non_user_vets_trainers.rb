class AddColmsToUserNonUserVetsTrainers < ActiveRecord::Migration
  def change
  	add_column :veterinarian, :phone_number, :string
  	add_column :veterinarian, :person_contact, :string
  	add_column :veterinarian, :comments, :string
  	add_column :veterinarian, :credit_card, :boolean, default: false

  	add_column :animal_facilities, :phone_number, :string

  	add_column :trainers, :phone_number, :string
  	add_column :trainers, :person_contact, :string
  	add_column :trainers, :comments, :string

  	remove_column :non_users, :is_non_user
  	add_column :non_users, :comments, :string
  	add_column :non_users, :home_comm, :string
  	add_column :non_users, :homecheck, :boolean, default: false
  	add_column :non_users, :disabled, :boolean, default: false

  	remove_column :users, :is_user
  	add_column :users, :comments, :string
  	add_column :users, :home_comm, :string
  	add_column :users, :homecheck, :boolean, default: false

  end
end
