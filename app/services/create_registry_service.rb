class CreateRegistryService
  def call course_id, user_id, role
    Registry.create! course_id: course_id, user_id: user_id, role: role
  end
end
