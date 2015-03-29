class AdminPolicy < ApplicationPolicy
  def index?
    user.admin? if !user.nil?
  end

  def courses?
    user.admin? if !user.nil?
  end
end

