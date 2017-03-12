class ChangeColTypes < ActiveRecord::Migration
  def change
  	change_column :adopteds, :adopt_date, :string
  	change_column :ani_sleeps, :sleep_date, :string
  	change_column :ani_transfers, :transfer_date, :string
  	change_column :foster_stages, :foster_date, :string

  	change_column :illnesses, :ill_date, :string
  	change_column :other_holds, :other_date, :string
  	change_column :trainings, :train_date, :string

  end
end
