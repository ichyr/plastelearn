class AdminController < ApplicationController

	PER_PAGE = 10

  after_action :verify_authorized

  respond_to :html

  def users_index
    authorize :admin

    pages = (Course.count / PER_PAGE) + 1
    current_page = params[:page].to_i > pages ? pages : params[:page]
    search = "%#{params[:search]}%"

    @users = User.where('name like ? and role = 0', search).order(:id)
                     .paginate(:page => current_page, :per_page => PER_PAGE)
  end

  def admins_index
    authorize :admin
    
    pages = (Course.count / PER_PAGE) + 1
    current_page = params[:page].to_i > pages ? pages : params[:page]
    search = "%#{params[:search]}%"

    @users = User.where('name like ? and role = 1', search).order(:id)
                     .paginate(:page => current_page, :per_page => PER_PAGE)
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
