class CreateMarketingTypes < ActiveRecord::Migration
  def change
    create_table :marketing_types do |t|

      t.string :name
    end
  end
end
