class CreateVettings < ActiveRecord::Migration
  def change
    create_table :vettings do |t|
      t.date :vet_date
      t.references :curr_vet
      t.references :curr_fost
      t.string :comments
    end
  end
end
