class CreateAdopters < ActiveRecord::Migration
  def change
    create_table :adopters do |t|
      t.references :non_user
      t.references :user
    end
  end
end
