class CreateMarketings < ActiveRecord::Migration
  def change
    create_table :marketings do |t|

      t.string :name
      t.references :animal
    end
  end
end
