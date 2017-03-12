class AddColmVet < ActiveRecord::Migration
  def change
    add_reference :vettings, :vet_hold
  end
end
