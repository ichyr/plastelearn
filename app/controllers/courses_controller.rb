class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @courses = Course.paginate(:page => params[:page], :per_page => 10)
    respond_with(@courses)
  end

  def show
    respond_with(@course)
  end

  def new
    @course = Course.new
    @course.parts

    respond_with(@course)
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    flash[:notice] = 'Course was successfully created.' if @course.save
    respond_with(@course)
  end

  def update
    flash[:notice] = 'Course was successfully updated.' if @course.update(course_params)
    respond_with(@course)
  end

  def destroy
    @course.destroy
    respond_with(@course)
  end

  def general_manage
    @course = Course.find(params[:id])
  end

  def parts_manage
    @course = Course.find(params[:id])
  end

  def members
    @course = Course.find(params[:id])
  end

  def statistics
    @course = Course.find(params[:id])
  end

  def enroll
    @course = Course.find(params[:id])
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title, :description, :enrollment_key)
    end
end
