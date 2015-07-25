class CreateAdminService
  def call
    user = User.find_or_create_by!(email: "admin@example.com", name: "SuperAdmin") do |user|
        user.password = Rails.application.secrets.admin_password || "changeme"
        user.password_confirmation = Rails.application.secrets.admin_password || "changeme"
        user.admin!
      end
  end
end
