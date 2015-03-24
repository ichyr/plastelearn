module ApplicationHelper
	def format_date date
		if date 
			date.strftime "%m/%d/%Y %H:%M"
		else 
			"No date specified"
		end
	end
end
