class CreateFosters < ActiveRecord::Migration
  def change
    create_table :fosters do |t|
      t.references :non_user
      t.references :user
    end
  end
end
