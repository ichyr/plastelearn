class CreateRegistries < ActiveRecord::Migration
  def change
    create_table :registries do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :role

      t.timestamps null: false
    end
  end
end
