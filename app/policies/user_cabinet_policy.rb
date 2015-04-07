class UserCabinetPolicy < ApplicationPolicy

	def courses?
		true unless user.nil?
	end

	def courses_teacher?
		true unless user.nil?
	end

	def courses_owner?
		true unless user.nil?
	end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
