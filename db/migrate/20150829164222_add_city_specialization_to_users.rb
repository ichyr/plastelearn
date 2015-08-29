class AddCitySpecializationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :specialization, :string
  end
end
