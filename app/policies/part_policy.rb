class PartPolicy < ApplicationPolicy

	# we can't access this page
	def index?
    false
  end

  def show?
    unless user.nil?
    	enrolled?(user, record)
    end
  end

  def new?
    privileged_enrolled?(user, record)
  end

  def create?
    privileged_enrolled?(user, record)
  end

  def edit?
    privileged_enrolled?(user, record)
  end

  def update?
    privileged_enrolled?(user, record)
  end

  def destroy?
    privileged_enrolled?(user, record)
  end

  def move_status?
  	privileged_enrolled?(user, record.course)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
