class Course < ActiveRecord::Base
	include Bootsy::Container

	mount_uploader :logo, LogoUploader
	
	has_many :parts

	has_many :registries, dependent: :destroy
  has_many :users, through: :registries

  after_create :set_defaults

  # validates :title, length: { in: 5..30 }
  # validates :enrollment_key, length: { minimum: 8 }
  # validates :short_description, length: { in: 10..255 }
  # validates :description, length: { minimum: 10 }
  # validates :title, :description, :short_description, :enrollment_key, presence: true

  def self.search(search)
    where('title LIKE ?', "%#{search}%")
  end

  def rating_restricted?
    puts self.rating_policy
    self.rating_policy
  end

  private
  def set_defaults
    self.documentation = "Please edit this in the course administration page!"
  end
end
