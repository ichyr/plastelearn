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
end
