class CreateAdopteds < ActiveRecord::Migration
  def change
    create_table :adopteds do |t|
      t.date :adopt_date
      t.references :adopter
      t.string :comments
    end
  end
end
