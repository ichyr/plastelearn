class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @courses = Course.where("public_visible = true").order(:created_at).paginate(:page => params[:page], :per_page => 10)
    respond_with(@courses)
  end

  def show
    unless current_user
      flash[:notice] = "Only registered user can access the courses. Please register!"
      redirect_to new_user_session_path
    else
      enrolled = Registry.where("user_id = ? and course_id = ?",
                                current_user.id, @course.id).count
      enrolled = enrolled > 0 ? true : false;

      if enrolled
        respond_with(@course)
      else
        redirect_to enroll_course_path(@course)
      end
    end
  end

  def new
    if current_user.course_grants > 0
      @course = Course.new
      @course.parts

      respond_with(@course)
    else
      flash[:notice] = "You can't create new courses. Please contact administrator for support!"
      redirect_to root
    end
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if current_user.course_grants > 0 && @course.save

      Registry.create course_id: @course.id,
                      user_id: current_user.id,
                      role: USER_COURSE_ROLES[:OWNER]
      current_user.course_grants -= 1;
      current_user.save!
                      
      flash[:notice] = 'Course was successfully created.'
      respond_with(@course)
    else
      flash[:notice] = "You can't create new courses. Please contact administrator for support!"
      redirect_to root
    end
  end

  def update
    flash[:notice] = 'Course was successfully updated.' if @course.update(course_params)
    respond_with(@course)
  end

  def destroy
    @course.destroy
    
    redirect_to :back
  end

  def general_manage
    @course = Course.find(params[:id])
  end

  def parts_manage
    @course = Course.find(params[:id])
  end

  def members
    @course = Course.find(params[:id])
    @registries = Registry.includes(:user)
                          .where("course_id = ?", @course.id).order(:id)
  end

  def statistics
    @course = Course.find(params[:id])
  end

  def enroll
    @course = Course.find(params[:id])
  end

  def check_enroll
    @course = Course.find(params[:id])

    if @course.enrollment_key == params[:enrollment][:enrollment_key]
      flash[:notice] = "You were sucessfully enrolled into the course #{@course.title}!"
      Registry.create(user_id: current_user.id,
                      course_id: @course.id,
                      role: USER_COURSE_ROLES[:STUDENT])
      redirect_to user_cabinet_path
    else
      flash[:notice] = 'Entered enrollment key is not correct.'
      redirect_to enroll_course_path(@course)
    end
  end






  # 
  # CANDIDATES FOR REFACTORING INTO HELPER STRUCTURES
  # 

  def assign_user_as_course_teacher
    user = User.find(params[:user_id])
    course = Course.find(params[:id])

    registry = get_registry(user, course)
    registry.role = USER_COURSE_ROLES[:TEACHER]
    registry.save!

    flash[:notice] = "User #{user.name} was assigned as a teacher for this course."
    redirect_to members_course_path(course)
  end

  def delete_user_from_course
    user = User.find(params[:user_id])
    course = Course.find(params[:id])

    registry = get_registry(user, course)
    registry.destroy!

    flash[:notice] = "User #{user.name} was deleted from members of this course."
    redirect_to members_course_path(course)
  end

  # 
  # CANDIDATES FOR REFACTORING INTO HELPER STRUCTURES
  # 



  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:title,
                                     :description,
                                     :enrollment_key,
                                     :bootsy_image_gallery_id,
                                     :public_visible,
                                     :short_description,
                                     :logo)
    end

    def get_registry user, course
      registry = Registry.where("course_id = ? and user_id = ?",
                               course.id, user.id).first
    end
end
