class Homework < ActiveRecord::Base
  belongs_to :part
  belongs_to :user
  has_many :comments
  has_many :ratings

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  def average_rating
    ratings.sum(:score) / ratings.size
  end
end
