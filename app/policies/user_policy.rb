class UserPolicy < ApplicationPolicy

  # noone should see this
  def index?
    false
  end

  def edit?
    unless user.nil?
      user.admin? || user.id == record.id  
    end
  end

  # implement in case of public profile
  def show?
    true unless user.nil?
  end

  def update?
    unless user.nil?
      user.admin? || user.id == record.id  
    end
  end

  def destroy?
    unless user.nil?
      user.admin? || user.id == record.id  
    end
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
