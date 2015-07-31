class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :parent_id
      t.integer :course_id
      t.text :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
