class ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  def owner?(user, course)
    check_role(user, course, USER_COURSE_ROLES[:OWNER])
  end

  def enrolled?(user, course)
    registry_entry(user, course).count > 0
  end

  def teacher?(user, course)
    check_role(user, course, USER_COURSE_ROLES[:TEACHER])
  end

  private
  def registry_entry(user, course)
    Registry.where("user_id = ? and course_id = ?", user.id, course.id)
  end

  def check_role(user, course, role)
    entry = registry_entry(user, course).first
    entry.role == role
  end
end

