class CoursePolicy < ApplicationPolicy

	# access check is performed in the controller
	def show?
		true
	end

	# access check is performed in the controller
	def new?
		true unless user.nil?
	end

	def edit?
		unless user.nil?
			user.admin? || owner?(user, record)
		end
	end

	# access check is performed in the controller
	def create?
		true unless user.nil?
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

	def report?
		unless user.nil?
			user.admin? || owner?(user, record) || teacher?(user, record)
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

  class Scope < Scope
    def resolve
      scope
    end
  end

end
