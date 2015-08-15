class CoursesController < ApplicationController
  before_action :set_course, except: [:index, :new, :create]
  after_action :verify_authorized, except: [:index]

  respond_to :html

  def index
    @courses = Course.where("public_visible = true and title like ?", search_param)
    .order(:created_at)
    .paginate(:page => params[:page], :per_page => 9)
  end

  def show
    authorize @course

    unless current_user
      flash[:notice] = "Only registered user can access the courses. Please register!"
      redirect_to new_user_session_path
    else
      add_breadcrumb I18n.t("general.breadcrumbs.home"), :root_path
      add_breadcrumb @course.title, course_path(@course)

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

  def documentation
    authorize @course

    add_breadcrumb I18n.t("general.breadcrumbs.home"), :root_path
    add_breadcrumb @course.title, course_path(@course)
    add_breadcrumb I18n.t("course.show.documentation"), documentation_course_path(@course)
  end

  def documentation_manage
    authorize @course
  end
  
  def discuss
    authorize @course

    add_breadcrumb I18n.t("general.breadcrumbs.home"), :root_path
    add_breadcrumb @course.title, course_path(@course)
    add_breadcrumb I18n.t("course.show.discuss"), discuss_course_path(@course)

    render layout: "course_posts"
  end

  def parts
    authorize @course

    unless current_user
      flash[:notice] = "Only registered user can access the courses. Please register!"
      redirect_to new_user_session_path
    else
      add_breadcrumb I18n.t("general.breadcrumbs.home"), :root_path
      add_breadcrumb @course.title, course_path(@course)
      add_breadcrumb I18n.t("course.show.parts"), parts_course_path(@course) 

      enrolled = Registry.where("user_id = ? and course_id = ?",
      current_user.id, @course.id).count
      enrolled = enrolled > 0 ? true : false;

      if enrolled
        @active_parts = @course.parts.where("status = ?", PART_STATUSES[:ACTIVE]).order(:id)
        @completed_parts = @course.parts.where("status = ?", PART_STATUSES[:COMPLETE]).order(:id)

        respond_with(@course)
      else
        redirect_to enroll_course_path(@course)
      end
    end
  end

  def new
    authorize Course.new

    if current_user.course_grants > 0
      @course = Course.new
      @course.parts

      respond_with(@course)
    else
      flash[:notice] = "You can't create new courses. Please contact administrator for support!"
      redirect_to root_path
    end
  end

  def edit
    authorize @course
  end

  def create
    authorize Course.new

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
      redirect_to root_path
    end
  end

  def update
    authorize @course

    flash[:notice] = 'Course was successfully updated.' if @course.update(course_params)
    respond_with(@course)
  end

  def destroy
    authorize @course

    @course.destroy

    redirect_to :back
  end

  def general_manage
    authorize @course
  end

  def parts_manage
    authorize @course

    @parts = @course.parts.order(:id)
  end

  def members
    authorize @course

    @registries = Registry.includes(:user)
    .where("course_id = ?", @course.id).order(:id)
  end

  def statistics
    authorize @course

    # get counts of parts with specified statuses
    @courses_count_pending = @course.parts.where("status = ?", PART_STATUSES[:PLANNED]).count
    @courses_count_active = @course.parts.where("status = ?", PART_STATUSES[:ACTIVE]).count
    @courses_count_completed = @course.parts.where("status = ?", PART_STATUSES[:COMPLETE]).count

    # sorted list of parts
    @sorted_parts = @course.parts.order(id: :ASC)

    # list of course students - subset of users of this course
    course_students_list = @course.registries.where("role = ?", USER_COURSE_ROLES[:STUDENT]).order(id: :ASC)
    @course_users = course_students_list.map { |reg| reg.user }

    @course_parts_count = @course.parts.count
    @course_users_count = @course_users.count

    # will count of submitted homeworks for every part
    @course_parts_done_data = []
    @course_parts_fail_data = []

    @sorted_parts.map { |part|
      temp = part.homeworks.where("user_id in (?)", @course_users).count

      @course_parts_done_data << temp
      @course_parts_fail_data << @course_users_count - temp
    }

    course_parts_ids = @sorted_parts.ids
    course_users_ids = @course_users.map(&:id)

    # get all homeworks for specific course
    course_homeworks = Homework.select(:user_id).where("part_id in (?)", course_parts_ids).map { |t|
      t.user_id
    }

    @course_users_hw_done = []
    @course_users_hw_failed = []
    course_parts_finished = @courses_count_completed + @courses_count_active

    # try to optimize the loop below
    @course_users.each_with_index { |user, index|
      temp = course_homeworks.count { |x| x == user.id }
      @course_users_hw_done << temp
      @course_users_hw_failed << (course_parts_finished - temp)
    }

  end

  def user_report
    authorize @course

    @user = User.find(params[:user_id])
    @parts = @course.parts.order(:id)
    part_ids = @user.homeworks.ids

    @homeworks = []
    @parts.each_with_index { |p, index|
      hw = p.homeworks
      match = nil
      hw.each { |hw|
        if part_ids.include?(hw.id)
          match = hw
          break
        end
      }
      @homeworks << match
    }
  end

  def part_report
    authorize @course

    @part = Part.find(params[:part_id])

    # list of course students - subset of users of this course
    course_students_list = @course.registries.where("role = ?", USER_COURSE_ROLES[:STUDENT])
    @users = course_students_list.map { |reg| reg.user }

    @homeworks = []
    @users.each { |user|
      match = nil
      @part.homeworks.each { |hw|
        if user.id == hw.user_id
          match = hw
          break
        end

      }
      @homeworks << match
    }
  end

  def enroll
    authorize @course
  end

  def check_enroll

    authorize @course

    if @course.enrollment_key == params[:enrollment][:enrollment_key]
      flash[:notice] = "You were sucessfully enrolled into the course #{@course.title}!"
      Registry.create(user_id: current_user.id,
      course_id: @course.id,
      role: USER_COURSE_ROLES[:STUDENT])
      redirect_to @course
    else
      flash[:notice] = 'Entered enrollment key is not correct.'
      redirect_to enroll_course_path(@course)
    end
  end


  #
  # CANDIDATES FOR REFACTORING INTO HELPER STRUCTURES
  #

  def assign_user_as_course_teacher
    authorize @course

    user = User.find(params[:user_id])

    registry = get_registry(user, @course)
    registry.role = USER_COURSE_ROLES[:TEACHER]
    registry.save!

    flash[:notice] = "User #{user.name} was assigned as a teacher for this course."
    redirect_to members_course_path(@course)
  end

  def delete_user_from_course
    authorize @course
    user = User.find(params[:user_id])

    registry = get_registry(user, @course)
    registry.destroy!

    flash[:notice] = "User #{user.name} was deleted from members of this course."
    redirect_to members_course_path(@course)
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
    :logo,
    :documentation)
  end

  def get_registry user, course
    registry = Registry.where("course_id = ? and user_id = ?",
    course.id, user.id).first
  end

  def search_param
    params[:search] ? "%#{params[:search]}%" : "%"
  end
end
