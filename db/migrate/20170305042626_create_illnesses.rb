class CreateIllnesses < ActiveRecord::Migration
  def change
    create_table :illnesses do |t|
      t.date :ill_date
      t.references :ill_vet
      t.string :ill_info
      t.string :comments
    end
  end
end
