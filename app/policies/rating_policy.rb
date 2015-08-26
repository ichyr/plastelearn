class RatingPolicy < ApplicationPolicy

	def update?(user, record)
  	unless user.nil?
    	true
      # enrolled?(user, record.part.course)
    else 
      false
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
