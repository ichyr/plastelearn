class AddRatingPermissionToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :rating_policy, :boolean, default: false
  end
end
