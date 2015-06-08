class AdminController < ApplicationController

	PER_PAGE = 10

  after_action :verify_authorized

  respond_to :html

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

  	pages = (Course.count / PER_PAGE) + 1
  	current_page = params[:page].to_i > pages ? pages : params[:page]
    search = "%#{params[:search]}%"

  	@courses = Course.where('title like ?', search)
                     .paginate(:page => current_page, :per_page => PER_PAGE)
  end
end
