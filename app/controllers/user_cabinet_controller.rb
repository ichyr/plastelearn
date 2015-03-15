class UserCabinetController < ApplicationController
  def attend
    # remove next statement
    current_user = User.find(1) unless current_user

    role = USER_COURSE_ROLES[:STUDENT]
    own_courses = get_course_ids_by_role(current_user, role)

    @courses = Course.find(own_courses)
  end

  def teacher
    # remove next statement
    current_user = User.find(1) unless current_user

    role = USER_COURSE_ROLES[:TEACHER]
    own_courses = get_course_ids_by_role(current_user, role)

    @courses = Course.find(own_courses)
  end

  def owner
    # remove next statement
    current_user = User.find(1) unless current_user

    role = USER_COURSE_ROLES[:OWNER]
    own_courses = get_course_ids_by_role(current_user, role)

    @courses = Course.find(own_courses)
  end


  private

  def get_course_ids_by_role(user, role)
    res = Registry.select(:course_id).where("user_id = ? and role = ?", user.id, role).pluck(:course_id)
    puts ""
    puts ""
    puts res
    puts ""
    puts ""
    res
  end
end
