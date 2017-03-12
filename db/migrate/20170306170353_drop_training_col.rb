class DropTrainingCol < ActiveRecord::Migration
  def up
  	remove_column :trainings, :train_hold_id
  end
end