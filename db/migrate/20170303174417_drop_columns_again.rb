class DropColumnsAgain < ActiveRecord::Migration
  def up
  	remove_column :intakes, :intake_stat_id
  end
end
