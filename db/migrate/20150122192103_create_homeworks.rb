class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.text :description
      t.integer :part_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
