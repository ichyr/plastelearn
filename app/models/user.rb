class User < ActiveRecord::Base
  enum role: [:user, :moderator, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :homeworks
  has_many :comments
  has_many :ratings

  has_many :registries
  has_many :courses, through: :registries

  mount_uploader :avatar, AvatarUploader
end
