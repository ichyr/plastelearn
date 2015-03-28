module CoursesHelper
  def table_row_count active, completed
    active = active.count
    completed = completed.count
    active > completed ? active : completed
  end

  def active_parts parts
    parts.select do |part| 
      part.status == PART_STATUSES[:ACTIVE]
    end
  end

  def completed_parts parts
    parts.select do |part| 
      part.status == PART_STATUSES[:COMPLETE]
    end
  end

  def get_status_name hash, number
    hash.to_a.each { |status|
      return status[0] if status[1] == number
    }
  end

  def user_status_decoration role
    role_title = get_status_name(USER_COURSE_ROLES, role)

    result = "<div class='btn btn-sm ";

    if role == USER_COURSE_ROLES[:STUDENT]
      result += "btn-success'>"
      result += '<span class="glyphicon glyphicon-headphones margin-right-15"></span>'
    elsif role == USER_COURSE_ROLES[:TEACHER]
      result += "btn-warning'>"
      result += '<span class="glyphicon glyphicon-leaf margin-right-15"></span>'
    elsif role == USER_COURSE_ROLES[:OWNER]
      result += "btn-primary'>"
      result += '<span class="glyphicon glyphicon-certificate margin-right-15"></span>'
    end

    result += "#{role_title}</div>"
  end

  def part_status_decoration role
    role_title = get_status_name(PART_STATUSES, role)

    result = "<div class='btn btn-sm ";

    if role == PART_STATUSES[:PLANNED]
      result += "btn-warning'>"
      result += '<span class="glyphicon glyphicon-time margin-right-15"></span>'
    elsif role == PART_STATUSES[:ACTIVE]
      result += "btn-success'>"
      result += '<span class="glyphicon glyphicon-refresh margin-right-15"></span>'
    elsif role == PART_STATUSES[:COMPLETE]
      result += "btn-primary'>"
      result += '<span class="glyphicon glyphicon-ok margin-right-15"></span>'
    end

    result += "#{role_title}</div>"
  end

  def part_state_transition_button part, state
    if state == PART_STATUSES[:PLANNED]
      link_to 'Start', move_status_part_path(part, status: PART_STATUSES[:ACTIVE]), 
              method: "PUT", class: "btn btn-default"
    elsif state == PART_STATUSES[:ACTIVE]
      link_to 'Finish', move_status_part_path(part, status: PART_STATUSES[:COMPLETE]),
              method: "PUT", class: "btn btn-default"
    elsif state == PART_STATUSES[:COMPLETE]
      link_to 'Reactivate', move_status_part_path(part, status: PART_STATUSES[:ACTIVE]),
              method: "PUT", class: "btn btn-default"
    end
  end

  def course_index_description_modal course
    short = course.short_description
    full = course.description
    target = 'course_index_item' + course.id.to_s
    text = "Read more..."
    title = "Course description"

    italics_decorator(short) +
    modal_button(target, text) +
    '<br />' +
    modal_large_body(target, title, full)
  end

  def how_to_create_course_modal
    target = "how-to-create"
    text = "How to create a course?"
    title = "How to create a course?"

    full = 
    "If you have no courses granted to create then you should contact the 
        administrator in order to get permissions to create a course."

    '<div class="btn btn-info">' +
    modal_button(target, text) +
    '</div>' +
    '<br />' +
    modal_large_body(target, title, full)
  end

end
