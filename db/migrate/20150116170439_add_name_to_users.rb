class AddNameToUsers < ActiveRecord::Migration
  def change
  	# set to represent both name and surname
    add_column :users, :name, :string
    add_column :users, :cell_phone, :string
    add_column :users, :information, :text
  end
end
