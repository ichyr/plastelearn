class Course < ActiveRecord::Base
	include Bootsy::Container
	
	has_many :parts

	has_many :registries, dependent: :destroy
  has_many :users, through: :registries
end
