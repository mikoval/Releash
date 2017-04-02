class CreateOtherStatuses < ActiveRecord::Migration
  def change
    create_table :other_statuses do |t|
      t.string :other_date
      t.references :sub_status
      t.references :animal
      t.string :comments
    end
  end
end
