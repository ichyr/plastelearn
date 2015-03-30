class CommentPolicy < ApplicationPolicy

	def create?
		enrolled_into_course?(user,record)
	end

	def update?
		enrolled_into_course?(user,record)
	end

	def destroy?
		enrolled_into_course?(user,record)
	end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private
  def enrolled_into_course?(user,record)
		unless user.nil?
    	enrolled?(user, record.homework.part.course)
    end	
  end
end
