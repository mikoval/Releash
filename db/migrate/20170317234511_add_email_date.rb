class AddEmailDate < ActiveRecord::Migration
  def change

    add_column :user_alerts, :email_date, :timestamp
  end
end
