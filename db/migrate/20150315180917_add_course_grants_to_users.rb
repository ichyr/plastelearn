class AddCourseGrantsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :course_grants, :integer
  end
end
