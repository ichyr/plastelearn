class HomeworkPolicy < ApplicationPolicy

	# we can't access this page
	def index?
    false
  end

  def show?
    valid_enrolled?(user, record)
  end

  def new?
    valid_enrolled?(user, record)
  end

  def create?
    valid_enrolled?(user, record)
  end

  def edit?
    valid_enrolled?(user, record.part.course) && user.id == record.user_id 
  end

  def update?
    valid_enrolled?(user, record.part.course) && user.id == record.user_id 
  end

  def destroy?
   valid_enrolled?(user, record.part.course) && user.id == record.user_id 
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def valid_enrolled?(user, record)
  	unless user.nil?
    	enrolled?(user, record)
    end
  end
end
