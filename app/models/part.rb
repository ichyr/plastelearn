class Part < ActiveRecord::Base
	include Bootsy::Container
	
	belongs_to :course
	has_many :homeworks

	after_initialize :set_defaults, :if => :new_record?

  def set_defaults
    self.status ||= PART_STATUSES[:PENDING]

    self.start_time = DateTime.now
    self.end_time = DateTime.now
  end

  def self.check_status_update
  	now = DateTime.now

  	Part.all.each do |part|
  		start_time = part.start_time
	  	end_time = part.end_time

	  	if start_time > now
	  		part.status = PART_STATUSES[:PENDING]
	  	elsif start_time < now && now > end_time
	  		part.status = PART_STATUSES[:ACTIVE]
	  	else
	  		part.status = PART_STATUSES[:COMPLETE]
	  	end

	  	part.save!
	  			
  	end
  end
end
