class AdminController < ApplicationController
  def index
  	@users = User.where("role = ?", 0)
  	@moderators = User.where("role = ?", 1)
  	@admins = User.where("role = ?", 2)
  end

  def courses
  	@courses = Course.paginate(:page => params[:page], :per_page => 10)
  end
end
