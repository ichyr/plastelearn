class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  respond_to :html

  def index
    authorize Homework.new

    @homeworks = Homework.all
    respond_with(@homeworks)
  end

  def show
    authorize @homework.part.course

    if current_user
      @rating = Rating.where(homework_id: @homework.id, 
                             user_id: current_user.id).first
      unless @rating
        @rating = Rating.create(homework_id: @homework.id, 
                                user_id: current_user.id, score: 0)
      end
    end

    @comments = @homework.comments.order(created_at: :desc)

    respond_with(@homework)
  end

  def new
    @homework = Homework.new part_id: params[:part_id]
    @homework.part

    authorize @homework.part.course
    
    respond_with(@homework)
  end

  def edit
    @homework.part
    authorize @homework
  end

  def create
    @homework = Homework.new(homework_params)

    authorize @homework.part.course

    @homework.save
    respond_with(@homework)
  end

  def update
    authorize @homework

    @homework.update(homework_params)    

    respond_with(@homework)
  end

  def destroy
    authorize @homework

    @homework.destroy
    respond_with(@homework)
  end

  private
    def set_homework
      add_breadcrumb I18n.t("general.breadcrumbs.home"), :root_path
      @homework = Homework.find(params[:id])
      add_breadcrumb @homework.part.course.title, course_path(@homework.part.course)
      add_breadcrumb @homework.part.title, part_path(@homework.part)
      add_breadcrumb I18n.t("general.breadcrumbs.homework", name: @homework.user.name)
    end

    def homework_params
      params.require(:homework).permit(:description, :part_id, :user_id, 
        :bootsy_image_gallery_id,
        attachments_attributes: [:id, :description, :file, "_destroy"])
    end
end
