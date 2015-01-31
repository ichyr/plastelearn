class Part < ActiveRecord::Base
	include Bootsy::Container
	
	belongs_to :course
	has_many :homeworks

	after_initialize :set_default_status, :if => :new_record?

  def set_default_status
    self.status ||= PART_STATUSES[:ACTIVE]
  end
end
