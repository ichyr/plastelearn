class UserCabinetController < ApplicationController
  def courses
    # remove next statement
    current_user = User.find(1) unless current_user

    role = USER_COURSE_ROLES[:STUDENT]
    own_courses = get_course_ids_by_role(current_user, role)

    @attend_courses = Course.select(:id, :title).find(own_courses)

    role = USER_COURSE_ROLES[:TEACHER]
    own_courses = get_course_ids_by_role(current_user, role)

    @teacher_courses = Course.select(:id, :title).find(own_courses)

    role = USER_COURSE_ROLES[:OWNER]
    own_courses = get_course_ids_by_role(current_user, role)

    @owner_courses = Course.select(:id, :title).find(own_courses)
  end


  private

  def get_course_ids_by_role(user, role)
    res = Registry.select(:course_id)
                  .where("user_id = ? and role = ?", user.id, role)
                  .pluck(:course_id)
  end
end