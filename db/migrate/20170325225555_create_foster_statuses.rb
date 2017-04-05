class CreateFosterStatuses < ActiveRecord::Migration
  def change
    create_table :foster_statuses do |t|
      t.string :foster_date
      t.references :foster
      t.references :adopter
      t.references :vet
      t.boolean :homecheck
      t.string :comments
      t.references :sub_status
      t.references :animal
    end
  end
end
