class Part < ActiveRecord::Base
	include Bootsy::Container
	
	belongs_to :course
	has_many :homeworks

	has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, :allow_destroy => true

	after_initialize :set_defaults, :if => :new_record?

	validates :title, length: { in: 5..30 }
  validates :short_description, length: { in: 10..255 }
  validates :description, length: { minimum: 10 }
  validates_with TimeValidator
  validates :title, :description, :short_description, presence: true

  def set_defaults
    self.status ||= PART_STATUSES[:PENDING]

    self.start_time = DateTime.now
    self.end_time = DateTime.now
  end

  def self.check_status_update
  	now = DateTime.now

  	#  Refactoring thing
  	# 
  	# loop through models
  	# add ids of elements to change to arrays => (pending|active|complete)
  	# where(id in (pending|active|complete)).update_all( set new status)
  	# 

  	Part.find_each do |part|
  		start_time = part.start_time
	  	end_time = part.end_time
	  	old_status = part.status

	  	if start_time > now
	  		puts "pending"
	  		part.status = PART_STATUSES[:PENDING]
	  	elsif start_time > now && now < end_time
	  		puts "active"
	  		part.status = PART_STATUSES[:ACTIVE]
	  	else
	  		puts "completed"
	  		part.status = PART_STATUSES[:COMPLETE]
	  	end

	  	if old_status != part.status
		  	part.save!
		  end
  	end

  end
end
