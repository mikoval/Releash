class AddColumnsHolds < ActiveRecord::Migration
  def change
  	add_reference :intakes, :intake_stat
    add_reference :intakes, :intake_hold
  end
end
