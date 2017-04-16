class AddDashboardToUser < ActiveRecord::Migration
  def change
    add_column :users, :dashboard, :string,  default: '[{"type":"animal-list", "x":0, "y":0, "height": 4 , "width": 5},
    {"type":"user-list", "x":5, "y":0, "height": 4 , "width": 5},
    {"type":"alert-list", "x":0, "y":5, "height": 4 , "width": 5}]'
  end
end
