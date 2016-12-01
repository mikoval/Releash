class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :kind

      t.timestamps null: false
    end
  end
end
