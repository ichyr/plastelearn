class CoursePolicy < ApplicationPolicy

	# access check is performed in the controller
	def show?
		true
	end

	def documentation?
		is_registered_enrolled?(user, record)
	end

	def discuss?
		is_registered_enrolled?(user, record)
	end

	def parts?
		is_registered_enrolled?(user, record)
	end

	def calendar?
		is_registered_enrolled?(user, record)
	end

	def get_module_info?
		is_registered_enrolled?(user, record)
	end

	def new?
		user.course_grants > 0
	end

	def edit?
		unless user.nil?
			user.admin? || owner?(user, record)
		end
	end

	# access check is performed in the controller
	def create?
		user.course_grants > 0
	end

	def update?
		unless user.nil?
			user.admin? || owner?(user, record)
		end
	end

	def destroy?
		unless user.nil?
			user.admin? || owner?(user, record)
		end
	end

	def general_manage?
		unless user.nil?
			user.admin? || owner?(user, record) || teacher?(user, record)
		end
	end

	def documentation_manage?
		unless user.nil?
			user.admin? || owner?(user, record) || teacher?(user, record)
		end
	end

	def parts_manage?
		unless user.nil?
			user.admin? || owner?(user, record) || teacher?(user, record)
		end
	end

	def members?
		unless user.nil?
			user.admin? || owner?(user, record)
		end
	end

	def statistics?
		unless user.nil?
			user.admin? || owner?(user, record) || teacher?(user, record)
		end
	end

	def user_report?
		unless user.nil?
			user.admin? || owner?(user, record) || teacher?(user, record)
		end
	end

	def part_report?
		unless user.nil?
			user.admin? || owner?(user, record) || teacher?(user, record)
		end
	end

	def enroll?
		true unless user.nil?
	end

	def check_enroll?
		true unless user.nil?
	end

	def assign_user_as_course_teacher?
		unless user.nil?
			user.admin? || owner?(user, record)
		end
	end

	def delete_user_from_course?
		unless user.nil?
			user.admin? || owner?(user, record)
		end
	end

	def is_rateable?
		if privileged_enrolled?(user, record)
			true
		elsif record.rating_restricted?
			false
		else
			true
		end
	end

	class Scope < Scope
		def resolve
			scope
		end
	end

	private
	def is_registered_enrolled?(user, course)
		unless user.nil? || !is_enrolled?(user, record)
			true
		else
			false
		end
	end

	def is_enrolled?(user, course)
		enrolled = Registry.where("user_id = ? and course_id = ?", 
															user.id, course.id).count
	  enrolled = enrolled > 0 ? true : false;
	  enrolled
	end

end
