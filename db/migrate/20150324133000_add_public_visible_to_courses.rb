class AddPublicVisibleToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :public_visible, :boolean, default: true
  end
end
