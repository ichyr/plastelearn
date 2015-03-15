class AddCourseGrantsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :course_grants, :number
  end
end
