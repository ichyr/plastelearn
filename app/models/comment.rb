class Comment < ActiveRecord::Base
	belongs_to :homework
	belongs_to :user

	# validates :text, length: { minimum: 15 }
end
