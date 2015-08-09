class AddDocumentationToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :documentation, :text
  end
end
