class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :title
      t.text :description
      t.integer :course_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status

      t.timestamps null: false
    end
  end
end
