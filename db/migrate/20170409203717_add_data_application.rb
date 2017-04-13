class AddDataApplication < ActiveRecord::Migration
  def change
  	add_column :animal_applications, :app_date, :string
  end
end
