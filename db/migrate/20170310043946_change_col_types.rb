class ChangeColTypes < ActiveRecord::Migration
  def change
  	change_column :adopteds, :adopt_date, :string
  	

  	change_column :trainings, :train_date, :string

  end
end
