class AdminPolicy < ApplicationPolicy
  def users_index?
    user.admin? unless user.nil?
  end

  def admins_index?
    user.admin? unless user.nil?
  end

  def courses?
    user.admin? unless user.nil?
  end
end

