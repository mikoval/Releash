class DropSleepTransfer < ActiveRecord::Migration
  def up
  	drop_table :ani_sleeps
  	drop_table :ani_transfers
  end
end
