class CreateSubStatusTypes < ActiveRecord::Migration
  def change
    create_table :sub_status_types do |t|
      t.string :name
    end
  end
end
