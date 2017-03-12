class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.date :train_date
      t.string :problem_info
      t.decimal :expense
      t.references :train_hold
    end
  end
end
