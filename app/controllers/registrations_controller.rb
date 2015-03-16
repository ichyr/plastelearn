class RegistrationsController < Devise::RegistrationsController
  after_action :set_defaults 

  protected

  def set_defaults
    resource.role ||= :user
    resource.course_grants = 0
  end
end