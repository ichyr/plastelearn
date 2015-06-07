class AdminController < ApplicationController

	PER_PAGE = 10

  after_action :verify_authorized

  def users_index
    authorize :admin
    
  	@users = User.where("role = ?", 0).order(:id)
  end

  def admins_index
    authorize :admin
    
    @admins = User.where("role = ?", 1).order(:id)
  end

  def courses
    authorize :admin

  	pages = Course.count / PER_PAGE
  	current_page = params[:page].to_i > pages ? pages : params[:page]

  	@courses = Course.paginate(:page => current_page, :per_page => PER_PAGE)
  end
end
