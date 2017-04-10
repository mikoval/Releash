class CreateIntakeReasons < ActiveRecord::Migration
  def change
    create_table :intake_reasons do |t|

      t.string :name
    end
  end
end
