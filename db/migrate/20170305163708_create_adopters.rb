class CreateAdopters < ActiveRecord::Migration
  def change
    create_table :adopters do |t|
      t.string :name
      t.string :street
      t.string :city
      t.integer :zip_code
      t.string :phone_number
      t.string :email_add

    end
  end
end
