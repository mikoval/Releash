class CreateFosters < ActiveRecord::Migration
  def change
    create_table :fosters do |t|
      t.string :user_id
      t.string :animal_id

      t.timestamps null: false
    end
  end
end
