module CoursesHelper
	def table_row_count active, completed
		active = active.count
		completed = completed.count
		active > completed ? active : completed
	end

	def active_parts parts
		parts.select do |part| 
			part.status == PART_STATUSES[:ACTIVE]
		end
	end

	def completed_parts parts
		parts.select do |part| 
			part.status == PART_STATUSES[:COMPLETE]
		end
	end

	def get_status_name hash, number
		hash.to_a.each { |status|
			return status[0] if status[1] == number
		}
	end

	def user_status_decoration role
		role_title = get_status_name(USER_COURSE_ROLES, role)

		result = "<div class='btn btn-sm ";

		if role == USER_COURSE_ROLES[:STUDENT]
		  result += "btn-success'>"
		  result += '<span class="glyphicon glyphicon-headphones margin-right-15"></span>'
		elsif role == USER_COURSE_ROLES[:TEACHER]
		  result += "btn-warning'>"
		  result += '<span class="glyphicon glyphicon-leaf margin-right-15"></span>'
		elsif role == USER_COURSE_ROLES[:OWNER]
		  result += "btn-primary'>"
		  result += '<span class="glyphicon glyphicon-certificate margin-right-15"></span>'
		end

		result += "#{role_title}</div>"
	end

end
