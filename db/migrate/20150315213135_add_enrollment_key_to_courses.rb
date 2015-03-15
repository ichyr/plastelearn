class AddEnrollmentKeyToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :enrollment_ket, :string
  end
end
