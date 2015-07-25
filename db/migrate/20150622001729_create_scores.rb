class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :user_id
      t.integer :part_id
      t.integer :value
      t.text :comment

      t.timestamps null: false
    end
  end
end
