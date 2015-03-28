class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @parts = Part.all
    respond_with(@parts)
  end

  def show
    add_breadcrumb @part.title, :root_path

    @part.homeworks

    @submitted = current_user_submitted_homework? @part, current_user

    respond_with(@part)
  end

  def new
    @part = Part.new
    @course = Course.find(params[:course_id])
    respond_with(@part)
  end

  def edit
    @course = Course.find(params[:course_id])
  end

  def create
    @part = Part.new(part_params)
    @part.save
    
    redirect_to parts_manage_course_path(@part.course)
  end

  def update
    @part.update(part_params)

    redirect_to parts_manage_course_path(@part.course)
  end

  def destroy
    @part.destroy
    
    redirect_to parts_manage_course_path(@part.course)
  end

  def move_status
    part = Part.find(params[:id])
    part.status = params[:status].to_i
    part.save!

    redirect_to parts_manage_course_path(part.course)
  end

  private
    def set_part
      add_breadcrumb "Home", :root_path
      @part = Part.find(params[:id])
      add_breadcrumb @part.course.title, course_path(@part.course)
    end

    def part_params
      params.require(:part).permit(:title,
                                   :description, 
                                   :course_id, 
                                   :start_time, 
                                   :end_time, 
                                   :status, 
                                   :short_description,
                                   :bootsy_image_gallery_id)
    end

    def current_user_submitted_homework? user, part
      cu_id = current_user.id
      homeworks = part.homeworks
      result = nil

      homeworks.each do |hw|
        if hw.user.id == cu_id
          result = hw
          break
        end
      end

      result
    end
end
