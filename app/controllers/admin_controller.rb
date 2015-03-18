class AdminController < ApplicationController
  def index
  	@users = User.where("role = ?", 0).order(:id)
  	@admins = User.where("role = ?", 1).order(:id)
  end

  def courses
  	@courses = Course.paginate(:page => params[:page], :per_page => 10)
  end
end
