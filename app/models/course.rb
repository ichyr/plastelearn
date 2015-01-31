class Course < ActiveRecord::Base
	include Bootsy::Container
	
	has_many :parts
end
