class UserPolicy < ApplicationPolicy

  def index?
    @current_user.admin?
  end

  def edit?
    # change this !
    true
  end

  def show?
    @current_user.admin? or @current_user == @user
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
