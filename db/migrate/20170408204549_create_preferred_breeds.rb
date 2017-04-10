class CreatePreferredBreeds < ActiveRecord::Migration
  def change
    create_table :breed_users do |t|
    	t.references :breed
    	t.references :user
    end
    create_table :breed_nonusers do |t|
    	t.references :breed
    	t.references :non_user
    end
  end
end
