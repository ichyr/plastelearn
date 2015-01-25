class Part < ActiveRecord::Base
	belongs_to :course
	has_many :homeworks

	after_initialize :set_default_status, :if => :new_record?

  def set_default_status
    self.status ||= PART_STATUSES[:ACTIVE]
  end
end
