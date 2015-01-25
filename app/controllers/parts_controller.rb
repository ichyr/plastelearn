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
    respond_with(@part)
  end

  def edit
  end

  def create
    @part = Part.new(part_params)
    @part.save
    respond_with(@part)
  end

  def update
    @part.update(part_params)
    respond_with(@part)
  end

  def destroy
    @part.destroy
    respond_with(@part)
  end

  private
    def set_part
      @part = Part.find(params[:id])
    end

    def part_params
      params.require(:part).permit(:title, :description, :course_id, :start_time, :end_time, :status)
    end
end
