class TimeValidator < ActiveModel::Validator
  def validate(record)
    if record.start_time < record.end_time
      record.errors[:start_time] << "Start time is after end time!"
      record.errors[:end_time] << "End time is before start time!"
    end
  end
end