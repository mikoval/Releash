class CreateVeterinarians < ActiveRecord::Migration
  def change
    create_table :veterinarians do |t|

      t.timestamps null: false
    end
  end
end
