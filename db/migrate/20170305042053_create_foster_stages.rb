class CreateFosterStages < ActiveRecord::Migration
  def change
    create_table :foster_stages do |t|
      t.date :foster_date
      t.references :curr_fost
      t.string :comment
      t.references :fost_hold
      
    end
  end
end
