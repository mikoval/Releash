class ChangeTypeIntak < ActiveRecord::Migration
  def up
    change_column :intakes, :intake_date, :string
  end
end
