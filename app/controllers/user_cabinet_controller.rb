class UserCabinetController < ApplicationController
  def courses
    authorize :user_cabinet

    role = USER_COURSE_ROLES[:STUDENT]
    own_courses = get_course_ids_by_role(current_user, role)

    @attend_courses = Course.select(:id, :title)
                            .search(params[:search])
                            .where("id in (?)", own_courses)
                            .paginate(:page => params[:page], :per_page => 10)
  end

  def courses_teacher
    authorize :user_cabinet

    role = USER_COURSE_ROLES[:TEACHER]
    own_courses = get_course_ids_by_role(current_user, role)

    @teacher_courses = Course.select(:id, :title)
                             .search(params[:search])
                             .where("id in (?)", own_courses)
                             .paginate(:page => params[:page], :per_page => 10)
  end

  def courses_owner
    authorize :user_cabinet

    @new_course_count = current_user.course_grants

    role = USER_COURSE_ROLES[:OWNER]
    own_courses = get_course_ids_by_role(current_user, role)

    @owner_courses = Course.select(:id, :title)
                           .search(params[:search])
                           .where("id in (?)", own_courses)
                           .paginate(:page => params[:page], :per_page => 10)

    @course_grants = I18n.t("user_cabinet.course_count", count: @new_course_count)
  end


  private

  def get_course_ids_by_role(user, role)
    res = Registry.select(:course_id)
                  .where("user_id = ? and role = ?", user.id, role)
                  .pluck(:course_id)
  end
end
