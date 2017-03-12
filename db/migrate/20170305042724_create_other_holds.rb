class CreateOtherHolds < ActiveRecord::Migration
  def change
    create_table :other_holds do |t|
	  t.date :other_date
      t.string :comments
    end
  end
end
