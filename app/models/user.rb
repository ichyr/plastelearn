class User < ActiveRecord::Base
  enum role: [:user, :admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :homeworks
  has_many :comments
  has_many :ratings
  has_many :scores
  has_many :posts

  has_many :registries, dependent: :destroy
  has_many :courses, through: :registries
  has_many :parts, through: :scores

  mount_uploader :avatar, AvatarUploader

  before_create :set_defaults

  private
  def set_defaults
    self.role ||= :user
    self.course_grants ||= 0
  end
end
