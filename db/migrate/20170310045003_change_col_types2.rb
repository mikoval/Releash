class ChangeColTypes2 < ActiveRecord::Migration
  def change
  	change_column :vettings, :vet_date, :string
  end
end
