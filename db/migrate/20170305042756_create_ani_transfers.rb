class CreateAniTransfers < ActiveRecord::Migration
  def change
    create_table :ani_transfers do |t|
      t.date :transfer_date
      t.string :comments
    end
  end
end
