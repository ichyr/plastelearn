class RatingPolicy < ApplicationPolicy

	def update?(user, record)
  	unless user.nil?
    	enrolled?(user, record.part.course)
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end