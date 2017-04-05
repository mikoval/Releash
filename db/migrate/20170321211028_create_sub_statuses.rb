class CreateSubStatuses < ActiveRecord::Migration
  def change
    create_table :sub_statuses do |t|
    	t.references :name
    	t.references :animal
    	t.string :comments
    end
  end
end
