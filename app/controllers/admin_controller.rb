class AdminController < ApplicationController
	PER_PAGE = 10

  def index
  	@users = User.where("role = ?", 0).order(:id)
  	@admins = User.where("role = ?", 1).order(:id)
  end

  def courses
  	pages = Course.count / PER_PAGE
  	current_page = params[:page].to_i > pages ? pages : params[:page]

  	@courses = Course.paginate(:page => current_page, :per_page => PER_PAGE)
  end
end
