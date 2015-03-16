class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @parts = Part.all
    respond_with(@parts)
  end

  def show
    @part.homeworks

    respond_with(@part)
  end

  def new
    @part = Part.new
    @course_id = params[:course_id]
    respond_with(@part)
  end

  def edit
    @course_id = params[:course_id]
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

  private
    def set_part
      @part = Part.find(params[:id])
    end

    def part_params
      params.require(:part).permit(:title, :description, :course_id, :start_time, :end_time, :status)
    end
end
