class Homework < ActiveRecord::Base
	include Bootsy::Container
	
  belongs_to :part
  belongs_to :user
  has_many :comments
  has_many :ratings

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  # validates :description, presence: true
  # validates :description, length: { minimum: 10 }

  def average_rating
    ratings.size != 0 ? ratings.sum(:score) / ratings.size : 0
  end
end
