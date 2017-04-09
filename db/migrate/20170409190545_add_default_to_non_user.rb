class AddDefaultToNonUser < ActiveRecord::Migration
  def change
  	 change_column_default :non_users, :foster_check, false
  	 change_column_default :non_users, :adopt_check, false
  end
end
