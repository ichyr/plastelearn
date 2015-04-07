class Course < ActiveRecord::Base
	include Bootsy::Container

	mount_uploader :logo, LogoUploader
	
	has_many :parts

	has_many :registries, dependent: :destroy
  has_many :users, through: :registries

  def self.search(search)
    where('title LIKE ?', "%#{search}%")
	end
end
