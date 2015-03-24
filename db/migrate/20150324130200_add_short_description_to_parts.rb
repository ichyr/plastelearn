class AddShortDescriptionToParts < ActiveRecord::Migration
  def change
    add_column :parts, :short_description, :string
  end
end