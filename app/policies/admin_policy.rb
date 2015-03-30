class AdminPolicy < ApplicationPolicy
  def index?
    user.admin? unless user.nil?
  end

  def courses?
    user.admin? unless user.nil?
  end
end

