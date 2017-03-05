class CreateAniSleeps < ActiveRecord::Migration
  def change
    create_table :ani_sleeps do |t|
      t.date :sleep_date
      t.string :comments
    end
  end
end
