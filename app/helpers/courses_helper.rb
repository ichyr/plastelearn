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

	def get_status_name number
		PART_STATUSES.to_a.each { |status|
			return status[0] if status[1] == number
		}
	end
end
