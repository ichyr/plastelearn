class CreateUserService
  def call email
    user = User.find_or_create_by!(email: email) do |user|
        user.password = Rails.application.secrets.admin_password || "changeme"
        user.password_confirmation = Rails.application.secrets.admin_password || "changeme"
      end
  end
end
