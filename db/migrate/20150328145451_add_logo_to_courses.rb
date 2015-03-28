class AddLogoToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :logo, :string
  end
end
