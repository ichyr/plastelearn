module ApplicationHelper
	def format_date date
		if date 
			date.strftime "%m/%d/%Y %H:%M"
		else 
			"No date specified"
		end
	end

	def format_date_comments date
		if date 
			date.strftime "%m %B of %Y at %H:%M"
		else 
			"No date specified"
		end
	end
end
